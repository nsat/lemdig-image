SUMMARY = "User space mappable dma buffer device driver for Linux"
DESCRIPTION = "User space mappable DMA Buffer"
LICENSE="MIT"
LIC_FILES_CHKSUM="file:///${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit module

PV = "1.2.3"
SRCREV = "d7703a48d46052617e9ff860b43aac936463cd44"
SRC_URI = "git://github.com/ikwzm/udmabuf.git \
           file://0001-Makefile-patch-for-Yocto-build.patch"

S = "${WORKDIR}/git/"

RPROVIDES_${PN} += "kernel-module-udmabuf"

KERNEL_MODULE_AUTOLOAD += "udmabuf "
