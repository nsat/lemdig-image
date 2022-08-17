FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Patch default QEMU PMU config object for Trenz TE0803 eval board (enables sd0 and can0 PM domains)
SRC_URI += "file://0001-Enable-PMU-nodes-for-Trenz-TE0803-SD0-and-can0.patch"
