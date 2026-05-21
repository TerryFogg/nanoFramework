//
// Copyright (c) .NET Foundation and Contributors
// See LICENSE file in the project root for full license information.
//
#include "network.h"
#include <tx_api.h>
#include <nx_driver_framework.h>
#include <NetworkConfigurationManager.h>

extern NX_DRIVER_INFORMATION nx_driver_information;
extern int g_Country_Code;
extern TX_BYTE_POOL byte_pool_0;
extern NetworkConfiguration networkConfiguration;
extern volatile ULONG g_netx_deferred_flags;

// ---- 2-phase polling state ----
// FAST until IP resolved
volatile bool g_fast_polling = true;
// short, tight polling burst
volatile bool g_burst_poll = false;

// ---- Tunables ----
// 300ms burst window
static const uint64_t BURST_DURATION_US = 300000;
// 2s without IP => stall
static const uint64_t DHCP_STALL_TIMEOUT_US = 2000000;
static const int DHCP_MAX_RETRIES = 3;

// NORMAL polling sleep: with 100Hz tick, 10 ticks ~= 100ms
static const ULONG NORMAL_SLEEP_TICKS = 10;

// How often to check "IP resolved" / stall condition (in microseconds)
static const uint64_t STATUS_CHECK_PERIOD_US = 100000; // 100ms

void Poll_cyw43_Thread(ULONG parameter);

#ifdef __cplusplus
extern "C"
{
#endif

#include "cyw43.h"
#include "cyw43_ll.h"
#include <pico/cyw43_arch.h>
#include "NetworkInterfaceAdapter.h"
#include <cstdlib>

    struct pbuf;
    uint16_t pbuf_copy_partial(const struct pbuf *p, void *dataptr, uint16_t len, uint16_t offset)
    {
        /* Stub function as it will never hit. */
        return 0;
    }

#ifdef __cplusplus
}
#endif

TX_THREAD TX_PollingThread;
extern UCHAR nx_driver_pico_w_link_up;
int scan_results_callback(void *env, const cyw43_ev_scan_result_t *result);
WifiConnectionStatus connectionStatus;
static const cyw43_ev_scan_result_t *scan_results;

void CreatePollingThread()
{
    void *pointer = TX_NULL;
    int POLL_THREAD_STACK_SIZE = 4000;
    int POLL_THREAD_PRIORITY = 5;
    ULONG parameter = 0;

    UINT status = tx_byte_allocate(&byte_pool_0, (VOID **)&pointer, POLL_THREAD_STACK_SIZE, TX_NO_WAIT);

    status = tx_thread_create(
        &TX_PollingThread,
        (char *)"Polling cyw43",
        Poll_cyw43_Thread,
        parameter,
        pointer,
        POLL_THREAD_STACK_SIZE,
        POLL_THREAD_PRIORITY,
        POLL_THREAD_PRIORITY,
        TX_NO_TIME_SLICE,
        TX_AUTO_START);
    if (status != TX_SUCCESS)
    {
        while (1)
        {
        }
    }
}

// Start the Wifi, default power management
bool Wifi::Initialize(uint8_t *mac)
{
    if (cyw43_arch_init() != PICO_ERROR_GENERIC)
    {
        // cyw43_arch_enable_sta_mode();
        cyw43_wifi_set_up(&cyw43_state, CYW43_ITF_STA, true, g_Country_Code);

        // Attempt to disconnect in case the AP has a stale entry
        // During debugging, power off without disconect etc leaves a stale entry
        // in the Access Point which is not cleared for some residential WiFi access points
        // resulting in no IP address being assigned
        cyw43_wifi_leave(&cyw43_state, CYW43_ITF_STA);
        tx_thread_sleep(10);

        cyw43_hal_get_mac(0, mac);

        // Disable low power mode to improve latency at the cost of higher power consumption at startup,set back to
        // default after connection
        cyw43_wifi_pm(&cyw43_state, CYW43_PERFORMANCE_PM);

        int result;
        bool notConnected = false;
        int FailureCount = 0;
        do
        {
            result = cyw43_arch_wifi_connect_timeout_ms(
                networkConfiguration.initialSSID,
                networkConfiguration.initialSSIDPassword,
                WIFI_AUTH_TYPE,
                WIFI_CONNECT_TIMEOUT);
            if (result != PICO_OK)
            {
                FailureCount++;
            }
        } while ((result != PICO_OK) && FailureCount < 3);

        g_fast_polling = true;
        CreatePollingThread();
        return (result == PICO_ERROR_NONE);
    }
    return false;
}
void Poll_cyw43_Thread(ULONG parameter)
{

    // Purpose:
    //   1) Drive CYW43 in polling mode (cyw43_arch_poll()).
    //   2) Provide fast "burst" polling after link-up and after DHCP restart to avoid missing early DHCP packets.
    //   3) Detect DHCP stalls (IP not resolved after timeout) and request a DHCP restart using NetX deferred
    //   processing. 4) Switch to low-CPU polling once IP is resolved.
    //
    // Assumptions / dependencies:
    //   - nx_driver_pico_w_link_up reflects PHY/L2 status (set by cyw43 callbacks).
    //   - nx_driver_information.nx_driver_information_ip_ptr is set by the driver during NX_LINK_INITIALIZE.
    //   - g_netx_deferred_flags + DEFERRED_FLAG_DHCP_RESTART are defined in Network.cpp.
    //   - Network.cpp handles NX_LINK_DEFERRED_PROCESSING and restarts DHCP when that flag is set.
    //   - ThreadX tick is 100Hz => tx_thread_sleep(1) is 10ms; we use tx_thread_relinquish() for sub-tick
    //   responsiveness.

    // dhcp "IP acquisition attempt" counters
    uint64_t dhcp_start_us = 0;
    int dhcp_retry_count = 0;

    // Fast or burst polling windows after link-up
    uint64_t burst_start_us = 0;
    g_fast_polling = true;

    // Periodic status check pacing (Throttle status checks)
    uint64_t last_check_us = 0;

    for (;;)
    {
        // ---------------------------------------------
        // (A) BURST MODE: tight polling loop (no sleep)
        // -------------------------------------------
        if (g_burst_poll && nx_driver_pico_w_link_up)
        {
            if (burst_start_us == 0)
            {
                burst_start_us = time_us_64();

                // Starting (or re-starting) the L3 bring-up timer.
                // If IP isn't resolved within DHCP_STALL_TIMEOUT_US, we will request a DHCP restart.
                if (dhcp_start_us == 0)
                {
                    dhcp_start_us = burst_start_us;
                    dhcp_retry_count = 0;
                }
            }

            // Drive CYW43 firmware (polling architecture)
            cyw43_arch_poll();

            // End burst after fixed duration
            if ((time_us_64() - burst_start_us) >= BURST_DURATION_US)
            {
                g_burst_poll = false;
                burst_start_us = 0;
            }

            // No sleep in burst mode: keep the loop tight
            continue;
        }

        // --------------------------
        // (B) Normal poll step
        // --------------------------
        cyw43_arch_poll();

        // If link is down, keep FAST mode armed and yield briefly
        if (!nx_driver_pico_w_link_up)
        {
            g_fast_polling = true;
            dhcp_start_us = 0;
            dhcp_retry_count = 0;

            // Yield CPU; not sleeping avoids 10ms minimum granularity
            // Review, check priority, may stall other nanoFramework requirements
            tx_thread_relinquish();
            continue;
        }

        // Fetch ip_ptr dynamically (it can be NX_NULL early in startup in your system)
        NX_IP *ip_ptr = nx_driver_information.nx_driver_information_ip_ptr;

        // If NetX isn't wired up yet, we can't check IP status; remain in FAST mode and yield
        if (ip_ptr == NX_NULL)
        {
            g_fast_polling = true;
            tx_thread_relinquish();
            continue;
        }

        // --------------------------
        // (C) 2-phase decision logic
        // --------------------------
        const uint64_t now_us = time_us_64();

        // Throttle status checks to reduce overhead
        if ((now_us - last_check_us) >= STATUS_CHECK_PERIOD_US)
        {
            last_check_us = now_us;

            // Check if IP is resolved (DHCP complete)
            ULONG actual = 0;
            UINT rc = nx_ip_interface_status_check(ip_ptr, 0, NX_IP_ADDRESS_RESOLVED, &actual, NX_NO_WAIT);

            if (rc == NX_SUCCESS)
            {
                // IP acquired => exit FAST mode
                g_fast_polling = false;
                g_burst_poll = false;

                // Clear DHCP supervision timers
                dhcp_start_us = 0;
                dhcp_retry_count = 0;
            }
            else
            {
                // IP not resolved yet: ensure we're in FAST mode
                g_fast_polling = true;

                // Start the stall timer on first observation after link-up
                if (dhcp_start_us == 0)
                {
                    dhcp_start_us = now_us;
                    dhcp_retry_count = 0;
                }

                // If DHCP has stalled too long, request a restart + re-enter burst
                if ((now_us - dhcp_start_us) >= DHCP_STALL_TIMEOUT_US)
                {
                    if (dhcp_retry_count < DHCP_MAX_RETRIES)
                    {
                        dhcp_retry_count++;

                        g_netx_deferred_flags |= DEFERRED_FLAG_DHCP_RESTART;
                        _nx_ip_driver_deferred_processing(ip_ptr);

                        // Re-enter burst to rapidly process OFFER/ACK right after restart
                        g_burst_poll = true;
                        burst_start_us = 0;

                        // Reset timer for next stall window
                        dhcp_start_us = now_us;
                    }
                    else
                    {
                        if (GenerateNewMacAndSet())
                        {
                            g_netx_deferred_flags |= DEFERRED_FLAG_UPDATE_MAC_ADDRESS;
                            _nx_ip_driver_deferred_processing(ip_ptr);
                        }
                        // Disconnect any previous session
                        cyw43_wifi_leave(&cyw43_state, CYW43_ITF_STA);
                        tx_thread_sleep(10); // Wait 100ms

                        // Reset retry count and timers for new MAC cycle
                        dhcp_retry_count = 0;
                        dhcp_start_us = now_us;
                    }
                }
            }
        }

        // --------------------------
        // (D) Sleep / yield policy
        // --------------------------
        if (g_fast_polling)
        {
            // With 100Hz tick, sleep(1) is 10ms; relinquish can yield without forced 10ms delay.
            tx_thread_relinquish();
        }
        else
        {
            // Normal operation: reduce CPU
            tx_thread_sleep(NORMAL_SLEEP_TICKS);
        }
    }
}
bool Wifi::Enable()
{
    cyw43_wifi_set_up(&cyw43_state, CYW43_ITF_STA, true, g_Country_Code);
    return true;
}
bool Wifi::Send(uint8_t *buffer, int length)
{
    int status = cyw43_send_ethernet(&cyw43_state, 0, length, buffer, false);
    if (status != 0)
    {
        return false;
    }
    return true;
}
bool Wifi::Receive()
{
    return true;
}
bool Wifi::MultiCastJoin()
{
    return true;
}
bool Wifi::MultiCastLeave()
{
    return true;
}
bool Wifi::DriverStatus()
{
    return true;
}
bool Wifi::Disconnect(HAL_Configuration_Wireless80211 wifiConfig)
{
    cyw43_arch_deinit();
    return true;
}
bool Wifi::Dispose()
{
    cyw43_arch_deinit();
    return true;
}

bool Wifi::WifiUp()
{
    // Only supports 'Client interface STA mode'             -
    int result = cyw43_wifi_link_status(&cyw43_state, CYW43_ITF_STA);
    return (result == 1);
}
bool Wifi::StartScan()
{
    cyw43_wifi_scan_options_t scan_options = {0};
    int err = cyw43_wifi_scan(&cyw43_state, &scan_options, NULL, scan_results_callback);
    return (err == 1);
}
bool Wifi::ScanActive()
{
    return cyw43_wifi_scan_active(&cyw43_state);
}

bool Wifi::GetAccessPointMaxStations()
{
    // At the time of writing this code
    // The CYW43 wireless driver in the Pico SDK does not support multiple simultaneous access points.
    return false;
}
bool Wifi::GetAccessPointMaxAssociations(int station)
{
    // At the time of writing this code
    // The CYW43 wireless driver in the Pico SDK does not support multiple simultaneous access points.
    // Ignore station number

    // Get maximum number of associated clients
    int num_stas;
    cyw43_wifi_ap_get_max_stas(&cyw43_state, &num_stas);
    return num_stas;
}
bool Wifi::GetAccessPointInformation(int station, int number_associations, access_point_connected_clients_t *apInfo)
{
    // At the time of writing this code
    // The CYW43 wireless driver in the Pico SDK does not support multiple simultaneous access points.
    // The CYW43 firmware and driver do not expose per-client RSSI metrics when the device is acting as an AP.

    uint8_t *list_of_macs = (uint8_t *)platform_malloc(number_associations * sizeof(access_point_connected_clients_t));
    if (list_of_macs != NULL)
    {
        {
            int num_stas;
            cyw43_wifi_ap_get_stas(&cyw43_state, &num_stas, list_of_macs);

            for (int i = 0; i < number_associations; i++)
            {
                memcpy(apInfo->mac, list_of_macs, 6);
                apInfo->phyModes = WIRELESS_PROTOCOL(-1);
                apInfo->rssi = 0;
                apInfo++;
                list_of_macs += 6;
            }
        }
        platform_free(list_of_macs);
        return true;
    }
    return false;
}
void Wifi::Connect(HAL_Configuration_Wireless80211 wifiConfig)
{
    size_t ssid_len = 64;
    const uint8_t *ssid = wifiConfig.Ssid;
    size_t key_len = 32;
    const uint8_t *key = wifiConfig.Password;
    const uint32_t channel = CYW43_CHANNEL_NONE;

    CLR_UINT32 AuthenticationType;
    switch (wifiConfig.Authentication)
    {
        case AuthenticationType::AuthenticationType_None:
        case AuthenticationType::AuthenticationType_Open:
            AuthenticationType = CYW43_AUTH_OPEN;
            break;
        case AuthenticationType::AuthenticationType_WPA:
            AuthenticationType = CYW43_AUTH_WPA_TKIP_PSK;
            break;
        case AuthenticationType::AuthenticationType_WPA2:
            AuthenticationType = CYW43_AUTH_WPA2_AES_PSK;
            break;
        // Not supported
        // Windows now
        case AuthenticationType::AuthenticationType_WCN:
        // Vunerable
        case AuthenticationType::AuthenticationType_WEP:
        case AuthenticationType::AuthenticationType_EAP:
        case AuthenticationType::AuthenticationType_PEAP:
        case AuthenticationType::AuthenticationType_Shared:
            AuthenticationType = -1;
            break;
            // Future support ?
            // CYW43_AUTH_WPA2_MIXED_PSK    WPA2/WPA mixed authorisation
            // CYW43_AUTH_WPA3_SAE_AES_PSK  WPA3 AES authorisation
            // CYW43_AUTH_WPA3_WPA2_AES_PSK WPA2/WPA3 authorisation
    }

    cyw43_wifi_join(&cyw43_state, ssid_len, ssid, key_len, key, AuthenticationType, NULL, channel);
    Events_Set(SYSTEM_EVENT_FLAG_WIFI_STATION);
}
int Wifi::NumberOfScanReportEntries()
{
    return 1;
}
bool Wifi::GetScanReport(ScanReportRecordMatchesManagedCode *reportEntries)
{
    const uint8_t unknown = 0;
    reportEntries = (ScanReportRecordMatchesManagedCode *)platform_malloc(
        sizeof(ScanReportRecordMatchesManagedCode) * NumberOfScanReportEntries());

    for (int i = 0; i < NumberOfScanReportEntries(); i++)
    {
        reportEntries->authMode = scan_results->auth_mode;
        for (int bs = 0; bs < 5; bs++)
        {
            reportEntries->bssid[bs] = scan_results->bssid[bs];
        }
        reportEntries->cypherType = scan_results->channel;
        reportEntries->rssi = scan_results->rssi;
        int scan_size = sizeof(scan_results->ssid);

        for (int s = 0; s < scan_size; s++)
        {
            if (s < scan_results->ssid_len)
            {
                reportEntries->ssid[s] = scan_results->ssid[s];
            }
            reportEntries->ssid[s] = 0;
        }
        reportEntries->cypherType = unknown;
    }
    return true;
}
bool Wifi::GetMACAddress(uint8_t *mac)
{
    cyw43_hal_get_mac(0, mac);
    return true;
}

int scan_results_callback(void *env, const cyw43_ev_scan_result_t *result)
{
    if (result)
    {
        scan_results = result;
        Events_Set(SYSTEM_EVENT_FLAG_WIFI_STATION);
    }
    return 0;
}

// Overrides of TCP/IP stack callbacks customised for NetXDuo
int cyw43_tcpip_link_status(cyw43_t *self, int itf)
{
    if (nx_driver_pico_w_link_up)
        return CYW43_LINK_UP;
    else
        return cyw43_wifi_link_status(self, itf);
}
void cyw43_cb_tcpip_init(cyw43_t *self, int itf)
{
    if (!nx_driver_pico_w_link_up)
        return;
    nx_driver_information.nx_driver_information_ip_ptr->nx_ip_driver_link_up = NX_TRUE;
    _nx_ip_driver_link_status_event(
        nx_driver_information.nx_driver_information_ip_ptr,
        nx_driver_information.nx_driver_information_interface->nx_interface_index);
}
void cyw43_cb_tcpip_deinit(cyw43_t *self, int itf)
{
    if (!nx_driver_pico_w_link_up)
        return;
    nx_driver_information.nx_driver_information_ip_ptr->nx_ip_driver_link_up = NX_FALSE;
    _nx_ip_driver_link_status_event(
        nx_driver_information.nx_driver_information_ip_ptr,
        nx_driver_information.nx_driver_information_interface->nx_interface_index);
}
void cyw43_cb_tcpip_set_link_up(cyw43_t *self, int itf)
{
    // Association complete
    // RX path active
    // NetX ready to accept packets

    nx_driver_pico_w_link_up = NX_TRUE;

    // Enter fast + burst polling
    g_fast_polling = true;
    g_burst_poll = true;
    cyw43_wifi_pm(&cyw43_state, CYW43_DEFAULT_PM);
}
void cyw43_cb_tcpip_set_link_down(cyw43_t *self, int itf)
{
    nx_driver_pico_w_link_up = NX_FALSE;
}
void cyw43_cb_process_ethernet(void *cb_data, int itf, size_t len, const uint8_t *buf)
{
    NX_PACKET *packet_ptr;
    if (!nx_driver_pico_w_link_up)
        return;

    /* Allocate a packet to receive data. */
    if (nx_packet_allocate(
            nx_driver_information.nx_driver_information_packet_pool_ptr,
            &packet_ptr,
            NX_RECEIVE_PACKET,
            NX_NO_WAIT))
    {

        /* No packet available. Just return. */
        return;
    }

    /* Adjust packet starting address to align IP header to 4 bytes boundary*/
    packet_ptr->nx_packet_prepend_ptr += 2;
    packet_ptr->nx_packet_append_ptr += 2;

    /* Append data to packet_ptr. */
    if (nx_packet_data_append(
            packet_ptr,
            (VOID *)buf,
            len,
            nx_driver_information.nx_driver_information_packet_pool_ptr,
            NX_NO_WAIT))
    {

        /* Error, release the packet. */
        nx_packet_release(packet_ptr);
        return;
    }

    /* Everything is OK, transfer the packet to NetX.  */
    nx_driver_transfer_to_netx(nx_driver_information.nx_driver_information_ip_ptr, packet_ptr);
}

bool GenerateNewMacAndSet()
{
    // No available API to change MAC address on the fly, so use low level call

    const uint32_t WLC_SET_VAR = 263;
    const uint32_t WWD_STA_INTERFACE = 0;
    uint8_t mac[6];
    srand(time_us_32());

    // Generate a new mac address
    mac[0] = 0x02;
    for (int i = 1; i < 6; ++i)
        mac[i] = rand() & 0xFF;

    // Set new MAC address
    int result = cyw43_ll_ioctl(
        (cyw43_ll_t *)&cyw43_state,
        WLC_SET_VAR,
        sizeof("cur_etheraddr"),
        (uint8_t *)"cur_etheraddr",
        WWD_STA_INTERFACE);

    if (result)
    {
        return true;
    }
    else
    {
        return false;
    }
}
