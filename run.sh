#!/usr/bin/env bash
set -euo pipefail

function usage() {
    >&2 echo -e "Usage: $0 [shell|tlc]\n" \
                "   build  -- Build the yocto image\n" \
                "   shell -- Get a shell in the yocto docker environment"
}

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

# Source environment variables for location of yocto cache etc
source "${SCRIPT_DIR}/yocto.env"

DL_DIR=${DL_DIR:-${LEMDIG_YOCTO_CACHE}/cache/downloads}
SSTATE_DIR=${SSTATE_DIR:-${LEMDIG_YOCTO_CACHE}/cache/sstate-cache}

SKIP_SERVICES_START=${SKIP_SERVICES_START:-1}

# Allow getopts above if needed
ARG1=${@:$OPTIND:1}
shift

if [ "x$ARG1" == "xshell" ]; then
    DOCKER_OPT=""
    CMD="/bin/bash"
elif [ "x$ARG1" == "xbuild" ]; then
    CMD="/lemdig/configure.sh && /lemdig/build.sh"
else
    usage
    exit 1
fi


SSTATE_MIRROR=${SSTATE_MIRROR:-}
if [ -n "$SSTATE_MIRROR" ]; then
    SSTATE_MIRRORS="file://.* file://$SSTATE_MIRROR/PATH"
    DOCKER_OPT="$DOCKER_OPT -v $SSTATE_MIRROR:$SSTATE_MIRROR"
else
    SSTATE_MIRRORS=""
fi

NO_TERM_OUTPUT=${NO_TERM_OUTPUT:-0}
# Make our docker interactive if we have a TTY
if [ -t 1 ] && [ "$NO_TERM_OUTPUT" != "1" ]; then
    DOCKER_OPT="$DOCKER_OPT -it"
fi

# Specifically used to allow Jenkins to use a tag besides "latest"
DOCKER_TAG=${DOCKER_TAG:-latest}

# Run the docker
# * Must be last so the return value of the build/docker is the return value of this script
#    Removed to save copy of build products \
docker run \
    -e LEMDIG_PROFILE="$LEMDIG_PROFILE" \
    -e YOCTO_DL_DIR=$DL_DIR \
    -e YOCTO_SSTATE_DIR=$SSTATE_DIR \
    -e YOCTO_SSTATE_MIRRORS="$SSTATE_MIRRORS" \
    -e USER_ID=$(id -u) \
    -e SKIP_SERVICES_START=$SKIP_SERVICES_START \
    -v $DL_DIR:$DL_DIR \
    -v $SSTATE_DIR:$SSTATE_DIR \
    -v $LEMDIG_TOP_DIR:$LEMDIG_TOP_DIR \
    -v $SCRIPT_DIR:/lemdig \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /dev/serial:/dev/serial \
    --net=host \
    --privileged \
    -w /lemdig \
    --rm \
    --init \
    $DOCKER_OPT \
    yocto-lemdig:${DOCKER_TAG} \
    "$CMD"