# This recipe is intended to be used when testing/debugging a new BOOT.bin by changing
# FSBL, U-Boot, ATF, PMU Firmware, and/or default PL image. By default, this recipe is
# not activated, and bitbake/meta-lemdig2/recipes-bsp/bootbin-prebuilt is used to
# populate the deploy directory with a pre-built BOOT.bin file (generated using Xilinx's
# bootgen command).

DESCRIPTION = "Generate BOOT.bin using mkbootimage"
LICENSE = "CLOSED"

PACKAGE_ARCH = "all"

SRC_URI += "file://zynqmp_fsbl.elf \
            file://boot.bif \
            file://design_1_wrapper.bit \
            "
PROVIDES = "virtual/bootbin"
S = "${WORKDIR}"

DEPENDS += "zynq-mkbootimage-native"

inherit deploy

# The configure function needs u-boot.elf, ATF, and PMU firmware to be deployed first
do_configure[depends] += " \
    u-boot-xlnx:do_deploy \
    arm-trusted-firmware:do_deploy \
    virtual/pmu-firmware:do_deploy \
    "

do_configure () {
	# PMU Firmware
	install ${DEPLOY_DIR_IMAGE}/pmu-firmware-${MACHINE}.elf ${S}/pmu-firmware-te0803-zynqmp.elf
	# ATF
	install ${DEPLOY_DIR_IMAGE}/arm-trusted-firmware.elf ${S}/
	# U-Boot
	install ${DEPLOY_DIR_IMAGE}/u-boot.elf ${S}/
}

do_compile () {
	mkbootimage --zynqmp boot.bif BOOT.bin
}

do_install () {
    :
}

do_deploy () {
	install -d ${DEPLOYDIR}
	install ${S}/BOOT.bin ${DEPLOYDIR}/
}

addtask do_deploy before do_build after do_install
