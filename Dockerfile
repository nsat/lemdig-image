FROM ubuntu:xenial-20180412

ENV PIP_VER=20.3.4
ENV PIP_USE_FEATURE=2020-resolver
ENV SETUPTOOLS_VER=44.0.0
ENV WHEEL_VER=0.33.6

ARG REPO_SRC="prod"
ARG DIST="xenial"

ENV DEBIAN_FRONTEND=noninteractive

COPY get-pip.py /usr/local/bin/get-pip.py

# Install essentials and python
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
        python-minimal \
        curl \
        build-essential checkinstall \
        libreadline-gplv2-dev libncursesw5-dev libssl-dev \
        libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
        uuid-dev liblzma-dev \
        && \
    apt-get -y clean && \
    curl -LO https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tar.xz && \
    tar -xf Python-3.8.7.tar.xz && \
    cd Python-3.8.7 && \
    ./configure --prefix=/usr --enable-optimizations && \
    make -j$(nproc) && make install && ldconfig && \
    cd .. && rm -rf Python-3.8.7 Python-3.8.7.tar.xz && \
    python3.8 /usr/local/bin/get-pip.py pip==${PIP_VER} setuptools==${SETUPTOOLS_VER} wheel==${WHEEL_VER} && \
    # Install pip
    /usr/local/bin/get-pip.py pip==${PIP_VER} setuptools==${SETUPTOOLS_VER} wheel==${WHEEL_VER}

RUN apt-get update && \
    apt-get -y upgrade && \    
    apt-get install -y \
        apt-transport-https \
        build-essential \
        chrpath \
        cpio \
        curl \
        diffstat \
        gawk \
        gcc-multilib \
        inetutils-ping \
        inotify-tools \
        libsdl1.2-dev \
        libssl-dev \
        locales \
        nfs-kernel-server \
        openssh-client \
        openssl \
        python \
        python-git \
        python3-git \
        python-dev \
        python-dateutil \
        rsync \
        runit \
        software-properties-common \
        sudo \
        texinfo \
        tftpd \
        udev \
        unzip \
        vim \
        wget \
        xinetd \
        can-utils \
        jq \
        lua5.2 \
        && \
    apt-get -y clean
    
# Yocto build demands the use of the en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Get a modern version of git
RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git-core git

# Install git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y git-lfs

# Install latest pip for our pip-depends Bitbake recipe
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade -r /tmp/requirements.txt

# Passwordless sudo for spire
RUN echo "spire ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

COPY startup_services.sh /startup_services.sh

# Set the TZ to UTC - bitbake DATETIME will be set appropriately
ENV TZ="UTC"

VOLUME ["/lemdig"]

WORKDIR /lemdig

ENTRYPOINT ["/startup_services.sh"]        
