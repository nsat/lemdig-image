#!/usr/bin/env bash

set -o errexit

if [ "_${3}" = "_" ]; then
  echo "Provide module (e.g. saam) name, platform (e.g. zynq7020) and intent (e.g. adsb_ais) as argument."
  exit 1
fi

module="${1}"
platform="${2}"
intent="${3}"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${SCRIPT_DIR}/common.env"

source_profile_setting
source_xilinx_setup_script
create_build_dir

cd "${FPGA_BUILD_DIR}" && (
  echo "Building top-level project..."
  mkdir -p top-level || error "Couldn't create 'top-level'"
  cd top-level
    make -j4 -f "${TOP_SRC_DIR}/Makefile"
  cd ..
)
