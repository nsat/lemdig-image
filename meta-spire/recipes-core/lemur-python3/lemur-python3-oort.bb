SUMMARY = "Lemur Spire oort-python3"
LICENSE = "CLOSED"

SRCREV = "d99bff3238677b93174de419a886734344ccc4c1"
PV = "1.3.0"

inherit python-dir

SRC_URI = "git://github.com/nsat/oort-sdk-python.git;protocol=https"

S = "${WORKDIR}/git"

inherit setuptools3
