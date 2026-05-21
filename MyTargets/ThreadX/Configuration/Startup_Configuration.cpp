// Copyright (c) .NET Foundation and Contributors
// See LICENSE file in the project root for full license information.

#include "NetworkConfigurationManager.h"
#include <cstring>
#include <cyw43_country.h>

extern NetworkConfiguration networkConfiguration;

// Default to worldwide, but can be overridden by configuration block
int g_Country_Code = CYW43_COUNTRY_WORLDWIDE;

int GetCountryCode()
{
    return CYW43_COUNTRY_WORLDWIDE;
}

bool ReadNetworkConfiguration()
{
    networkConfiguration.initialIP = IP_ADDRESS(0, 0, 0, 0);
    networkConfiguration.initialGateway = IP_ADDRESS(0, 0, 0, 0);
    strncpy(networkConfiguration.initialSSID, "Telstra02A9D1", sizeof(networkConfiguration.initialSSID) - 1);
    strncpy(
        networkConfiguration.initialSSIDPassword,
        "2zcqqyr3se",
        sizeof(networkConfiguration.initialSSIDPassword) - 1);

    if (GetCountryCode() != 0)
    {
        g_Country_Code = GetCountryCode();
    }

    return true;
}
