SUMMARY = "Library for UAVCANv0 support"
HOMEPAGE = "https://legacy.uavcan.org/Implementations/Libuavcan/"
SECTION = "libs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1b59e4524bdc7bdb14e2af001b180e14"

SRCREV = "dcc3a4de237b7482e04543d2393c3a9385685312"
PV = "1.0.0rc-last+git${SRCPV}"

SRC_URI = "git://github.com/UAVCAN/libuavcan.git;protocol=https;branch=legacy-v0"

S = "${WORKDIR}/git"

DEPENDS = ""

inherit cmake
