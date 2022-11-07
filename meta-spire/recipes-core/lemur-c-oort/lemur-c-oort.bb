SUMMARY = "Lemur Spire oort-C API"
LICENSE = "CLOSED"

# Build a cmake project
inherit cmake

DEPENDS = " curl"
RDEPENDS+${PN} = " libcurl libc"

SRCREV = "642ef4279fd9876c38cca6c4c6421c240710ba44"
PV = "1.3.0"

SRC_URI = "git://github.com/nsat/oort-sdk-c.git;protocol=https"

INSANE_SKIP_${PN} += " ldflags"
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"
SOLIBS = ".so"
FILES_SOLIBSDEV = ""

S = "${WORKDIR}/git"

