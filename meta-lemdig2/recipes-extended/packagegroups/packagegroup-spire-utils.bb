DESCRIPTION = "Command Line Utilities"
LICENSE = "GPLv2"

inherit packagegroup

PACKAGES = "\
    packagegroup-spire-utils \
    packagegroup-spire-utils-basic \
    packagegroup-spire-utils-extended \
    packagegroup-spire-utils-extra \
    packagegroup-spire-utils-compression \
    "

RDEPENDS_packagegroup-spire-utils = "\
    packagegroup-spire-utils-basic \
    packagegroup-spire-utils-extended \
    packagegroup-spire-utils-compression \
    "    

RDEPENDS_packagegroup-spire-utils-basic = "\
    packagegroup-core-full-cmdline-initscripts \
    bash \
    acl \
    attr \
    bc \
    coreutils \
    cpio \
    chrony \
    chronyc \
    e2fsprogs \
    ed \
    file \
    findutils \
    gawk \
    gmp \
    grep \
    makedevs \
    mktemp \
    ncurses \
    net-tools \
    popt \
    procps \
    psmisc \
    sed \
    spire-public-keys-only \
    time \
    util-linux \
    os-release \
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
    lmsensors-sensors \
    lmsensors-sensorsdetect \
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
    chrpath \
    dosfstools \
    expect \
    mtools \
    strace \
    lsof \
    perf \
    i2c-tools \
    devmem2 \
    screen \
    sysbench \
    monit \
    oort \
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

RDEPENDS_packagegroup-spire-utils-extra = "\
    canutils \
    dosfstools \
    ethtool \
    fio \
    i2c-tools \
    lrzsz \
    memtester \
    minicom \
    mtd-utils \
    mtd-utils-misc \
    mtd-utils-ubifs \
    netcat \
    nfs-utils-client \
    opkg-utils \
    pciutils \
    picocom \
    rpm \
    screen \
    sqlite3 \
    start-stop-daemon \
    u-boot-fw-utils \
    update-alternatives-opkg \
    usbutils \
    util-linux-hwclock \
    vim \
    "
