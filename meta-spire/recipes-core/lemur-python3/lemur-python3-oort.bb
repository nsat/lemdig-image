SUMMARY = "Lemur Spire oort-python3"
LICENSE = "CLOSED"

SRCREV = "d99bff3238677b93174de419a886734344ccc4c1"
PV = "1.3.0"

inherit python3-dir

RDEPENDS_${PN} = " \
    python3-urllib3 \
    python3-six \
    python3-dateutil \
    "
    
SRC_URI = "git://github.com/nsat/oort-sdk-python.git;protocol=https"

S = "${WORKDIR}/git"

inherit setuptools3
