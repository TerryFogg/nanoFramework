

This repository is setup to include 

1. nf-interpreter as a submodule and reference the code.
```
git submodule add https://github.com/nanoframework/nf-interpreter.git nf-interpreter
git submodule update --init --recursive
```
2.Espressif's ESP-IDF as a submodule and reference the code.
```
git submodule add https://github.com/espressif/esp-idf.git esp-idf
git submodule update --init --recursive
git checkout v5.5
git submodule update --init --recursive
```


### Updating features via the Kconfig system
Copy the default values and run the menuconfig to produce a .config file
```
python -m defconfig targets/ESP32/defconfig/ESP32_P4_UART_REV_LESS3_defconfig
python -m menuconfig 
python -m savedefconfig -out targets/ESP32/defconfig/ESP32_P4_UART_REV_LESS3_defconfig
```



