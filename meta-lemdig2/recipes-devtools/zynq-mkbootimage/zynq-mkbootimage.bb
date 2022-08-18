DESCRIPTION = "Generates BOOT.bin file"

BBCLASSEXTEND = "native nativesdk"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM="file:///${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/antmicro/zynq-mkbootimage.git \
           file://0001-Makefile-patch-remove-flags.patch \
           file://0002-register-init.patch \
           "
SRCREV = "4490a1816f6f6c0bf98b0097dff1eb2f83c21f6a"
S = "${WORKDIR}/git/"

DEPENDS += "elfutils-native pcre-native"

do_install() {
	install -d ${D}${bindir}
	install ${S}/mkbootimage ${D}${bindir}
}
