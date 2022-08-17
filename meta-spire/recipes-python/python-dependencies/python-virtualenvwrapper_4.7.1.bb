DESCRIPTION = "virtualenvwrapper"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=09d11a5cce530e0a83ed2ab189abcd14"
SRC_URI[md5sum] = "3789e0998818d9a8a4ec01cfe2a339b2"
SRC_URI[sha256sum] = "3bf73ede42a689adeedc8ac85662cb539665d3d029459bc8d3e6835ecd81ffde"

DEPENDS = "${PYTHON_PN}-pbr ${PYTHON_PN}-pbr-native"
RDEPENDS_${PN} += " \
    ${PYTHON_PN}-virtualenv \
    ${PYTHON_PN}-virtualenv-clone \
    ${PYTHON_PN}-stevedore \
"

do_configure() {
    echo "Do nothing"
}

inherit pypi setuptools
