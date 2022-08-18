SUMMARY = "This module provides UAVCAN v0 support to python"
HOMEPAGE = "https://legacy.uavcan.org/Implementations/Pyuavcan/"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0249574e7552cd65846752d7e94660b9"

SRCREV = "acf1e158a5224fb969117b9c96119ab767886090"
PV = "1.0.0.dev32+git${SRCPV}"

inherit python-dir

SRC_URI = "git://github.com/UAVCAN/pyuavcan.git;branch=legacy-v0;protocol=https"

S = "${WORKDIR}/git"

inherit setuptools
