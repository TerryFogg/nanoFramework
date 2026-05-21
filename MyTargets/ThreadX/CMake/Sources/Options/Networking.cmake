#
# Copyright (c) .NET Foundation and Contributors
# See LICENSE file in the project root for full license information.
#
# Locals
 list(APPEND NETWORK_INCLUDES
    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net
    ${NF_INTERPRETER_SOURCE_DIR}/src/boards/includes
    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/sockets/ssl
)
 list(APPEND NETWORK_SOURCES
    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native.cpp
    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_Security_CertificateManager.cpp
    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/sockets/ssl/ssl.cpp

    # Make local copies of these (next section) due to official source reliance on sockets and lwip
    # ------------------------------------------------------------------------------
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_IPAddress.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_NetworkInformation_IPGlobalProperties.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_NetworkInformation_NetworkInterface.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_NetworkInformation_WirelessAPConfiguration.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_NetworkInformation_Wireless80211Configuration.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_Security_SslNative.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Net_Sockets_NativeSocket.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Security_Cryptography_X509Certificates_X509Certificate.cpp
    #    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net/sys_net_native_System_Security_Cryptography_X509Certificates_X509Certificate2.cpp
)

 list(APPEND NETWORK_SOURCES                        

    # Included by specific drivers
       #${PLATFORM_SOURCE_DIR}/Device/nx_driver_framework.c
    ${PLATFORM_SOURCE_DIR}/Device/Network.Helpers.cpp
    ${PLATFORM_SOURCE_DIR}/Device/Network.cpp

    ${PLATFORM_SOURCE_DIR}/Library/Network.Information.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Network.Interface.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Network.Security.SslNative.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Network.Sockets.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Network.WirelessAPConfiguration.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Network.Wireless80211Configuration.cpp
    
)

 list(APPEND NETWORK_SOURCES
    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Wifi/sys_dev_wifi_native.cpp
    ${PLATFORM_SOURCE_DIR}/Library/Wifi.Adapter.cpp
)

list(APPEND OPTIONAL_SOURCES
    ${NETWORK_SOURCES}
)

list(APPEND OPTIONAL_INCLUDES
    ${NETWORK_INCLUDES}
)
