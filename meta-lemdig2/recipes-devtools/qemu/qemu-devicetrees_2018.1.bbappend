FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

COMPATIBLE_MACHINE = "marsupial-zynqmp"

SRC_URI_append_marsupial-zynqmp = " file://te0803-arm.dts;subdir=git/ "
