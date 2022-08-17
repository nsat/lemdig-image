# .bbappend file for overriding do_compile step of meta-xilinx/recipes-bsp/arm-trusted-firmware_2018.1.
# Sets appropriate flags for using UART1 as the device to print console logs to.
do_compile() {
    oe_runmake -C ${S} BUILD_BASE=${B} PLAT=${PLATFORM} RESET_TO_BL31=1 bl31 ZYNQMP_CONSOLE=cadence1
}
