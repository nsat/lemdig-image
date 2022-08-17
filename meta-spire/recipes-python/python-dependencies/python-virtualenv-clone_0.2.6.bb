DESCRIPTION = "virtualenv-clone"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=93a0ae49656299faef17cb7fece99e95"
SRC_URI[md5sum] = "fb03cd8c7a2be75937a13756d14068fc"
SRC_URI[sha256sum] = "6b3be5cab59e455f08c9eda573d23006b7d6fb41fae974ddaa2b275c93cc4405"

RDEPENDS_${PN} += " \
	${PYTHON_PN}-virtualenv \
"

inherit pypi setuptools
