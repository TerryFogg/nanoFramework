#
# Copyright (c) .NET Foundation and Contributors
# See LICENSE file in the project root for full license information.
#

# NOT USED
 #    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/nanoRingBuffer/nanoRingBuffer.c

# NOT USED (Yet)
 #    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Device.Can/nf_device_can_native.cpp
 #    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Device.OneWire/nf_dev_onewire.cpp

 #    ${NF_INTERPRETER_SOURCE_DIR}/src/System.IO.Ports/sys_io_ser_native_System_IO_Ports_SerialPort__.cpp

# Common
        list(APPEND NF_INTERPRETER_INCLUDES 
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Include
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Debugger
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Helpers/Base64
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Helpers/nanoprintf
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/NativeEventDispatcher
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Startup
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/System.Math
                    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/Network/Enc28j60
                    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/Networking.Sntp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/DeviceInterfaces/System.Net
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/Include
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Devices.Can
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Devices.OneWire
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.ResourceManager
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.IO.Hashing
                   # ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Security.Cryptography
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Text
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Include
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/sockets
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/sockets/ssl
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/sockets/ssl/mbedTLS
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Lwip
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Events
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Adc
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Dac
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Gpio
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2c.Slave
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2s
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Pwm
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Spi
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.UsbStream
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Wifi
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.IO.FileSystem
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.IO.Ports
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.IO.Ports
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Runtime.Serialization
        )
        list(APPEND NF_INTERPRETER_SOURCES
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Cache.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Checks.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_DblLinkedList.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Array.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_ArrayList.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_BinaryBlob.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Delegate.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Delegate_List.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Finalizer.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Lock.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_LockRequest.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Node.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Queue.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Stack.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_String.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_Timer.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapBlock_WaitForObject.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_HeapCluster.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_Interop.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_Memory.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_ObjectToEvent_Destination.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_ObjectToEvent_Source.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_RuntimeMemory.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_StackFrame.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_SystemAssembliesTable.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/CLR_RT_UnicodeHelper.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Core.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Execution.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/GarbageCollector.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/GarbageCollector_Compaction.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/GarbageCollector_ComputeReachabilityGraph.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/GarbageCollector_Info.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Interpreter.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/nanoSupport_CRC32.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Random.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Streams.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/StringTable.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/StringTableData.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Thread.cpp
# Use Copy          ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/TypeSystem.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/TypeSystemLookup.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Various.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Hardware/Hardware.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Hardware/Hardware_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/InterruptHandler/InterruptHandler.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/InterruptHandler/InterruptHandler_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/NativeEventDispatcher/NativeEventDispatcher.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/NativeEventDispatcher/NativeEventDispatcher_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/RPC/CLR_RT_HeapBlock_EndPoint.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/RPC/RPC_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Serialization/BinaryFormatter.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Core/Serialization/BinaryFormatter_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_AppDomain.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Array.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Attribute.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_BitConverter.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Collections_ArrayList.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Convert.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_DateTime.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Delegate.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Diagnostics_Debug.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Diagnostics_Debugger.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Double.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Enum.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Exception.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_GC.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Globalization_CultureInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Globalization_DateTimeFormat.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Guid.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_MarshalByRefObject.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_MathInternal.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_MulticastDelegate.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Number.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Object.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Random.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_Assembly.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_Binder.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_ConstructorInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_FieldInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_MemberInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_MethodBase.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_PropertyInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_RuntimeFieldInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Reflection_RuntimeMethodInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_RuntimeType.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Runtime_CompilerServices_RuntimeHelpers.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Runtime_Remoting_RemotingServices.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_String.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_AutoResetEvent.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_Interlocked.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_ManualResetEvent.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_Monitor.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_SpinWait.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_Thread.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_Timer.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Threading_WaitHandle.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_TimeSpan.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_Type.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_ValueType.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/CorLib/corlib_native_System_WeakReference.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Debugger/Debugger.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Debugger/Debugger_full.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Debugger/Debugger_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics/Diagnostics_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics/Info.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics/Info_Safeprintf.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics/Profile.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Diagnostics/Profiler.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Helpers/Base64/base64.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Helpers/nanoprintf/nanoprintf.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Messaging/Messaging.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Messaging/Messaging_stub.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/Startup/CLRStartup.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/System.Math/nf_native_system_math.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/System.Math/nf_native_system_math_System_Math.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/WireProtocol/WireProtocol_App_Interface.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/WireProtocol/WireProtocol_HAL_Interface.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/WireProtocol/WireProtocol_Message.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/CLR/WireProtocol/WireProtocol_MonitorCommands.c
#                   ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_Boot.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_Capabilites.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_ConfigurationManager.c
                    #${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_ConfigurationManager_stubs.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_SystemEvents.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_SystemInformation.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_Time.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_Watchdog.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.ResourceManager/nf_system_resourcemanager.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.ResourceManager/nf_system_resourcemanager_nanoFramework_Runtime_Native_ResourceUtility.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.ResourceManager/nf_system_resourcemanager_System_Resources_ResourceManager.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Events/nf_rt_events_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Events/nf_rt_events_native_nanoFramework_Runtime_Events_EventSink.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Events/nf_rt_events_native_nanoFramework_Runtime_Events_NativeEventDispatcher.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Events/nf_rt_events_native_nanoFramework_Runtime_Events_WeakDelegate.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_nanoFramework_Runtime_Hardware_SystemInfo.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_nanoFramework_Runtime_Native_ExecutionConstraint.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_nanoFramework_Runtime_Native_GC.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_nanoFramework_Runtime_Native_Power.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_nanoFramework_Runtime_Native_Rtc_stubs.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.Runtime.Native/nf_rt_native_System_Environment.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections/nf_system_collections.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections/nf_system_collections_System_Collections_Hashtable.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections/nf_system_collections_System_Collections_Hashtable__HashtableEnumerator.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections/nf_system_collections_System_Collections_Queue.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Collections/nf_system_collections_System_Collections_Stack.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.IO.Hashing/nf_sys_io_hashing.cpp
                   # ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Security.Cryptography/nf_sys_sec_cryptography.cpp
                   # ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Security.Cryptography/nf_sys_sec_cryptography_System_Security_Cryptography_Aes.cpp
                   # ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Security.Cryptography/nf_sys_sec_cryptography_System_Security_Cryptography_HMACSHA256.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Text/nf_system_text.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Text/nf_system_text_System_Text_UTF8Decoder.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/nanoFramework.System.Text/nf_system_text_System_Text_UTF8Encoding.cpp
# To be reintegrated into core later

#  ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/AsyncProcCall/AsyncCompletions.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/AsyncProcCall/AsyncContinuations.cpp

                    #${NF_INTERPRETER_SOURCE_DIR}/src/PAL/AsyncProcCall/Async_stubs.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/BlockStorage/nanoPAL_BlockStorage.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/COM_stubs.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/COM/GenericPort_stdio.c
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Double/nanoPAL_NativeDouble.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Events/nanoPAL_Events.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Events/nanoPAL_Events_driver.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Events/nanoPAL_Events_functions.cpp
#                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/FileSystem/nanoPAL_FileSystem.cpp
#                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/FileSystem/nanoPAL_FileSystem_stubs.cpp
#                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Lwip/lwIP_Sockets_functions.cpp
#                    ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Lwip/lwIP_Sockets.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/PAL/Profiler/nanoPAL_PerformanceCounters_stubs.cpp
              #     ${NF_INTERPRETER_SOURCE_DIR}/src/PAL/nanoPAL_Network_stubs.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Adc/sys_dev_adc_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Dac/sys_dev_dac_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Gpio/sys_dev_gpio_native.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Gpio/sys_dev_gpio_native_System_Device_Gpio_GpioController.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Gpio/sys_dev_gpio_native_System_Device_Gpio_GpioPin.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2c/sys_dev_i2c_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2c.Slave/sys_dev_i2c_slave_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.I2s/sys_dev_i2s_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Pwm/sys_dev_pwm_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Spi/sys_dev_spi_native.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Spi/nanoHAL_Spi.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Spi/sys_dev_spi_native_System_Device_Spi_SpiBusInfo.cpp
                    #${NF_INTERPRETER_SOURCE_DIR}/src/System.Device.Spi/sys_dev_spi_native_System_Device_Spi_SpiDevice.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.IO.Ports/sys_io_ser_native.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Runtime.Serialization/nf_system_runtime_serialization.cpp
                    ${NF_INTERPRETER_SOURCE_DIR}/src/System.Runtime.Serialization/nf_system_runtime_serialization_System_Runtime_Serialization_Formatters_Binary_BinaryFormatter.cpp
        )

# Targets
        list(APPEND NF_INTERPRETER_INCLUDES 
                    ${PLATFORM_SOURCE_DIR}/Configuration
                    ${PLATFORM_SOURCE_DIR}/Startup
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}
                    ${PLATFORM_SOURCE_DIR}/Device
                    ${PLATFORM_SOURCE_DIR}/Library
                    ${PLATFORM_SOURCE_DIR}/nanoFramework.Graphics																																																																																																																																																																																							
                    ${PLATFORM_SOURCE_DIR}/nanoFramework.Hardware
                    ${PLATFORM_SOURCE_DIR}/Other																																																																																																																																																																																							
                    ${PLATFORM_SOURCE_DIR}/Other/RequiredNotUsed
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption
                    ${PLATFORM_SOURCE_DIR}/WireProtocol
                    ${PLATFORM_SOURCE_DIR}/Startup

                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/Common
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/Common/WireProtocol
        )
        list(APPEND NF_INTERPRETER_SOURCES 

                    ${PLATFORM_SOURCE_DIR}/Configuration/Startup_Configuration.cpp
                    ${PLATFORM_SOURCE_DIR}/Configuration/targetHAL_ConfigurationManager.cpp

                    ${PLATFORM_SOURCE_DIR}/Other/CircularBuffer.cpp
                    ${PLATFORM_SOURCE_DIR}/Other/CortexM_HardFaultHandler.c
                    ${PLATFORM_SOURCE_DIR}/Other/nanoCRT.cpp
                    ${PLATFORM_SOURCE_DIR}/Other/nanoHAL_Boot.c
                    ${PLATFORM_SOURCE_DIR}/Other/sys_calls.c


# To be reintegrated into core later
                    ${PLATFORM_SOURCE_DIR}/Temporary_src/CLR/Core/TypeSystem.cpp
                    ${PLATFORM_SOURCE_DIR}/Temporary_src/PAL/AsyncProcCall/AsyncCompletions.cpp

                    ${PLATFORM_SOURCE_DIR}/Device/DevicePin.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/Adc.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/Dac.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/Gpio.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/I2c.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/I2c.slave.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/I2s.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/Pwm.cpp
                    ${PLATFORM_SOURCE_DIR}/Library/Spi.cpp
                    ${PLATFORM_SOURCE_DIR}/Device/AsychronousIO.cpp

               ##     ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/nx_driver_framework.cpp


                    ${PLATFORM_SOURCE_DIR}/nanoFramework.Hardware/nanoframework_Hardware.cpp
                    ${PLATFORM_SOURCE_DIR}/nanoFramework.Hardware/nanoframework_Hardware_nanoframework_Hardware_NativeFunctions.cpp

                    ${PLATFORM_SOURCE_DIR}/Library/IO.Ports.SerialPort.cpp

                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/ManagedThreadSupport.cpp
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/Memory.cpp
                    
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/targetHAL_Rtos.c
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/targetHAL_Time.cpp
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/targetPAL_Events.cpp
                    ${PLATFORM_SOURCE_DIR}/ThreadX.Adaption/targetPAL_Time.cpp

                    # Core RTOS ThreadX threads
                    ${PLATFORM_SOURCE_DIR}/Startup/RTOS_Thread_Creation.cpp


                    ${PLATFORM_SOURCE_DIR}/WireProtocol/WireProtocol_MonitorCommands.c
                    ${PLATFORM_SOURCE_DIR}/WireProtocol/WireProtocol_Receiver.cpp

                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/Delays.cpp
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/Device.IO.cpp																																																																																																																																																																																							
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/FlashDriver.cpp
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/nanoSupport_CRC32.c
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/WireProtocol_HAL_Interface.c
                    ${PLATFORM_SOURCE_DIR}/Vendors/${TARGET_VENDOR}/${TARGET_FAMILY}/wp_Communications.c
                    
        )  

# Overide compile flags on selected files
    # Set flags on code that is required but produces warning/errors with current build parameters
#    set_source_files_properties(${NF_INTERPRETER_SOURCE_DIR}/src/HAL/nanoHAL_Boot.c COMPILE_FLAGS -Wno-unused-parameter)
