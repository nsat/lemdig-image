DESCRIPTION = "Command Line Utilities"
LICENSE = "GPLv2"

inherit packagegroup

PACKAGES = "\
    packagegroup-spire-utils \
    packagegroup-spire-utils-basic \
    packagegroup-spire-utils-compression \
    packagegroup-spire-utils-extended \
    packagegroup-spire-utils-python-pip \
    packagegroup-spire-utils-services \
    "

RDEPENDS_packagegroup-spire-utils = "\
    packagegroup-spire-utils-basic \
    packagegroup-spire-utils-compression \
    packagegroup-spire-utils-extended \
    packagegroup-spire-utils-python-pip \
    packagegroup-spire-utils-services \
    "    

RDEPENDS_packagegroup-spire-utils-basic = "\
    acl \
    attr \
    bash \
    bc \
    canutils \
    coreutils \
    cpio \
    dosfstools \
    e2fsprogs \
    ed \
    ethtool \
    file \
    findutils \
    gawk \
    gmp \
    grep \
    i2c-tools \
    lrzsz \
    makedevs \
    minicom \
    mktemp \
    mtd-utils \
    mtd-utils-misc \
    mtd-utils-ubifs \
    ncurses \
    net-tools \
    netcat \
    nfs-utils-client \
    opkg-utils \
    os-release \
    packagegroup-core-full-cmdline-initscripts \
    pax \
    pciutils \
    picocom \
    popt \
    procps \
    psmisc \
    resolvconf \
    rpm \
    screen \
    sed \
    sqlite3 \
    start-stop-daemon \
    time \
    u-boot-fw-utils \
    update-alternatives-opkg \
    usbutils \
    util-linux \
    util-linux-hwclock \
    vim \
    "

# Python dependencies via pip
RDEPENDS_packagegroup-spire-utils-python-pip += "\
    python-Cerberus \
    python-SPI-Py \
    python-args \
    python-arrow \
    python-atomicwrites \
    python-bitstring \
    python-construct \
    python-dateutil \
    python-elasticsearch \
    python-inotify \
    python-ipython \
    python-mock \
    python-msgpack \
    python-numpy \
    python-pathlib2 \
    python-prettytable \
    python-psutil \
    python-pyserial \
    python-requests \
    python-setuptools \
    python-six \
    python-smbus \
    python-urllib3 \
    python-zfec \
    "

RDEPENDS_packagegroup-spire-utils-extended = "\
    sudo \
    diffutils \
    glibc-utils \
    elfutils \
    m4 \
    byacc \
    patch \
    setserial \
    which \
    wget \
    python \
    iproute2 \
    iputils \
    iptables \
    module-init-tools \
    less \
    nano \
    rsync \
    inotify-tools \
    lmsensors-sensors \
    oprofile \
    parted \
    sysstat \
    iperf3 \
    jq \
    gdb \
    lsof \
    memtester \
    "

RDEPENDS_packagegroup-spire-utils-services = "\
    at \
    openssl \
    sysfsutils \
    openssh-sftp-server \
    "

RDEPENDS_packagegroup-spire-utils-compression = "\
    zlib \
    tar \
    gzip \
    zip \
    unzip \
    xz \
    bzip2 \
    "
