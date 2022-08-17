DESCRIPTION = "Toolchain Package Groups"
LICENSE = "GPLv2"

inherit packagegroup

RDEPENDS_${PN} = "\
    packagegroup-core-buildessential \
    cmake \
    git \
    python-compiler \
    python-pip \
    python-virtualenv \
    python-virtualenvwrapper \
    python-misc \
    python-dev \
    python-typing \
    python-futures \
    "
