#!/usr/bin/env bash

set -o errexit

if [ "_${2}" = "_" ]; then
  echo "Provide module (e.g. saam) name and platform (e.g. zynq7020) as argument."
  exit 1
fi

module="${1}"
platform="${2}"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${SCRIPT_DIR}/common.env"

source_profile_setting
