DESCRIPTION = "stevedore"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SRC_URI[md5sum] = "9e9da130107153e06d8919c077032f29"
SRC_URI[sha256sum] = "1bdeb2562d8f2c1e3047c2f17134a38b37a6e53e16ca1d9f79ff2ac5d5fe2925"

DEPENDS = "${PYTHON_PN}-pbr ${PYTHON_PN}-pbr-native"
RDEPENDS_${PN} += " \
	${PYTHON_PN}-six \
"

inherit pypi setuptools
