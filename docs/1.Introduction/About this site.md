---
layout: default
title: About this site
nav_order: 1
has_children: true
permalink: /docs/GettingStarted

---

# About This Site

The open source documentation for **nanoFramework** which is created by many great volunteers can be found at [**docs.nanoFramework.net**](https://docs.nanoframework.net/index.html),

This site is focused on my own notes relating to work on the nanoFramework. 

**nanoFramework** runs on many MCU devices and platforms with the smallest as low as 256kB of flash and 64kB of RAM. although this is constrained. I have opted to use MCU's with a larger Flash/RAM  base. In the Hardware section of this document you can view the MCU's used.

Below is a summary of the benefits I see .





- Runs directly on bare metal. Currently there is support for [ARM Cortex-M](https://en.wikipedia.org/wiki/ARM_Cortex-M) and [Xtensa LX6 and LX7](https://en.wikipedia.org/wiki/ESP32) cores.
- Supports common embedded peripherals and interconnects like GPIO, UART, SPI, I2C, USB, networking.
- Provides multithreading support natively.
- Support for energy-efficient operation such as devices running on batteries.
- Support for Interop code allowing developers to easily write libraries that have both managed (C#) and native code (C/C++).
- No manual memory management because of its simpler mark-and-sweep [garbage collector](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)).
- Execution constrains to catch device lockups and crashes.

Here are some advantages over other similar systems:

- First class debugger experience right on the target hardware with breakpoints, single step, step into, step out, step over, pause and stop.
- Powerful and free programming environment with [Microsoft Visual Studio IDE](https://www.visualstudio.com/vs/).
- Support for a large range of inexpensive boards from several manufacturers including: Discovery and Nucleo boards from [ST Microelectronics](http://www.st.com/content/st_com/en.html), [ESP32 and S2](https://en.wikipedia.org/wiki/ESP32) series, [CC1352R1-LAUNCHXL](https://www.ti.com/tool/LAUNCHXL-CC1352R1) from Texas Instruments, [i.MXRT1060](https://www.nxp.com/design/development-boards/i.mx-evaluation-and-development-boards/mimxrt1060-evk-i.mx-rt1060-evaluation-kit:MIMXRT1060-EVK) from NXP and many others.
- Easily expandable to other hardware platforms and [RTOSes](https://en.wikipedia.org/wiki/Real-time_operating_system). Currently is targeting [ChibiOS](http://www.chibios.org/dokuwiki/doku.php), FreeRTOS, TI-RTOS and ESP32 FreeRTOS port.
- Completely free and [Open Source](https://en.wikipedia.org/wiki/Free_and_open-source_software). From the core components to the utilities used for building, deploying, debugging and IDE components.

