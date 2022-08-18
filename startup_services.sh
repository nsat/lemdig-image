#!/bin/bash
# This runs any additional routines during startup of the bash session.

set -euo pipefail

# Setup running user (spire)
USER_ID=${USER_ID:-1000}
echo "Starting with UID: $USER_ID"
# make the home dir if it doesn't already exist
if [ ! -d /home/spire ]; then
    makehome="--create-home"
fi

useradd --shell /bin/bash --uid "${USER_ID}" --groups root,dialout --non-unique ${makehome:-} --home /home/spire spire
# If home already existed because ~/encryption is mounted in, copy skel files
if [ -z ${makehome+x} ]; then
    cp -r /etc/skel/. /home/spire
fi

# Ensure the spire home dir is owned by spire
chown spire:spire /home/spire

HOME=/home/spire
exec sudo --preserve-env --shell --user spire $@