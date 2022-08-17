SUMMARY = "FPGA Clock Configuration Device Driver for Linux"
DESCRIPTION = "FPGA Clock Configuration Device Driver for Linux"
LICENSE="MIT"
LIC_FILES_CHKSUM="file:///${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit module

PV = "1.1.0"
SRCREV = "305400ad173164b176b6f87815949ac7aa06e784"
SRC_URI = "git://github.com/ikwzm/fclkcfg.git \
           file://0001-Makefile-patch-for-Yocto-build.patch"

S = "${WORKDIR}/git/"

RPROVIDES_${PN} += "kernel-module-fclkcfg"

KERNEL_MODULE_AUTOLOAD += "fclkcfg"

