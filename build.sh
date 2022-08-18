#!/bin/bash -e

# Run configure 
/lemdig/configure.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
echo "SCRIPT_DIR - ${SCRIPT_DIR}"

# Source environment variables common between linux and the docker
source "${SCRIPT_DIR}/yocto.env"

# Source common functions and environment variables.
source "${SCRIPT_DIR}/common.env"

# Enters build directory
cd_build
pwd

# Enter poky directory
pushd poky &>/dev/null || error "Couldn't enter poky directory"
pwd

# Initialize build environment
source "oe-init-build-env"

rm -rf tmp

# Do build
bitbake lemdig-image
#bitbake lemdig-image-qemu
bitbake lemdig-image-bootstrap
bitbake lemdig-image-bootstrap-complete
