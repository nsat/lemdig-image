#!/usr/bin/env bash
set -euo pipefail

# Install docker if not installed already
DOCKER_INSTALL_STATUS=`dpkg -l | grep docker.io | grep -o ^..`
if [ "x$DOCKER_INSTALL_STATUS" == "xii" ]
then
    echo "Docker already installed"
else
    # install docker
    sudo apt-get install -y docker.io
    
    # Add user to the docker group
    sudo usermod -a -G docker ${USER}
fi


# build the docker image
docker build -t yocto-lemdig .
