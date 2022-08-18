SUMMARY = "Packages constituting the LEMSDR payload system"

PR = "r1"

inherit packagegroup distro_features_check

PACKAGES = "\
    ${PN}-core \
    "

RDEPENDS_${PN}-core = "\
    libiio \
    libiio-dev \
    libiio-tests \
    libiio-iiod \
    python-pyzmq \
    zeromq \
    zeromq-dev \
    opencv \
    v4l-utils \
   "