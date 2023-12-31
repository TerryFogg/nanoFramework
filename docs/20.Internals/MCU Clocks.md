---
layout: default
title: MCU Clocks
parent: nanoFramework Internals
nav_order: 1
---

# MCU Clocks



Depending on the 



DWT (data watch point and trace) counter re-use

During start up of peripherals, sometimes a short delay (in the order of microseconds) is required after writing t a register before continuing with further configuration. Although the SYSTICK can be used, in Azure-RTOS, the granularity is 10 milliseconds, which is a long time to wait if there are many registers to write and wait. In the arm Cortex there is also a DWT counter, the DWT is a debug unit that provides watchpoints and system profiling for the processor that is normally used for system debug and tracing. This is a specialised requirement and for this application this is not required and it is re-used to generate very short delays as required. DWT has a number of features and does depend on the processor, for the Cortex-M7 of the STM32H7 we will use the 32-bit register called CYCCNT, which is an up counter of the processor CPU clock cycles. By tracking the clock cycles, we can generate an accurate time delay given that the operating frequency of the CPU is known or can be known For the STMH735IG used on the STM735G-DK board, the CPU clock frequency is rated at 550MHz. The counter will increment every 1/550,000,000 ~ 1.9ns, and the counter is 32-bits giving a maximum delay of ~8.2 seconds. Since we are using this for very short delays, the counter feature of the DWT is great. 

Systick

 The STM32H7xx has an arm Coretex-M core processor. Each Cortex-M and some other Cortex cores have a standard 24 bit countdown timer with autoreload. The SysTick counter will countdown from its initial value, once it reaches zero it will raise an interrupt and a new count value will be loaded from the reload register. The main purpose of this timer is to generate a periodic interrupt for a real-time operating system (RTOS) or other event driven software. After the STM32H7xx is reset the SysTick registers are set to the following. **Address Name Type Reset Description** 0xE000E010 SYST_CSR RW 0x00000000 SysTick Control and Status Register 0xE000E014 SYST_RVR RW Unknown SysTick Reload Value Register 0xE000E018 SYST_CVR RW Unknown SysTick Current Value Register 0xE000E01C SYST_CALIB RO 0x3E8 SysTick Calibration Value Register The interrupt for the STM32H7 is in the NVIC table with the following properties Address : 0x0000 003CPriority : 6 The SysTick timer source clock by default is the CPU clock divided by 8, see Figure 1.

![img](assets/clip_image002-1687182875730-54-1687502303547-1.png)

**Figure 1.**

 

![img](assets/clip_image004-1687182875730-55-1687502303548-2.png)

**Figure 2**

Azure-RTOS and startup

When the Azure-RTOS kernel is started, the first call is tx_initialize_low_level.s. The code does not have any specific STM32H7 code and appears to be CORTEX-M common ( to followup). This is where the SysTick frequency is setup as the base timer for the RTOS. There are two variables that define the frequency. SYSTEM_CLOCK = 520000000 <-- T*his value should be changed to match your CPU clock configuration* SYSTICK_CYCLES = ((SYSTEM_CLOCK / 100) -1) The value is setup, see Figure 2

 

 
