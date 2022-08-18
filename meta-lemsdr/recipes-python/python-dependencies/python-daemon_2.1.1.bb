DESCRIPTION = "python-daemon - Library to implement a well-behaved Unix daemon process."
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://LICENSE.GPL-3;md5=d32239bcb673463ab874e80d47fae504"

SRC_URI[md5sum] = "72e2acf2c3d69c7fa75a6625d06adfd0"
SRC_URI[sha256sum] = "58a8c187ee37c3a28913bef00f83240c9ecd4a59dce09a24d92f5c941606689f"

DEPENDS = "${PYTHON_PN}-docutils-native"
RDEPENDS_${PN} += " \
	${PYTHON_PN}-docutils \
	${PYTHON_PN}-setuptools \
	${PYTHON_PN}-lockfile \
"

PYPI_PACKAGE = "python-daemon"

inherit pypi setuptools
