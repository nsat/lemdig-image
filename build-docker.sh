#!/usr/bin/env bash

# Install docker if not installed already
DOCKER_INSTALL_STATUS=`dpkg -l | grep docker.io | grep -o ^..`
if [ "x$DOCKER_INSTALL_STATUS" != "xii" ]
then
    # build the docker image
    docker build -t yocto-lemdig .
else
    # install docker
    sudo apt-get install -y docker.io
    
    # Add user to the docker group
    sudo usermod -a -G docker ${USER}
    
    echo "Please reboot the machine to allow the user to use docker then re-run this script"
fi

