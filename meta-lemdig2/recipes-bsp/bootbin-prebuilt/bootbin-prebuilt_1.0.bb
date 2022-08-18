DESCRIPTION = "Copy prebuilt BOOT.bin to the deploy directory"
LICENSE = "CLOSED"

PACKAGE_ARCH = "all"
SRC_URI += "file://BOOT.bin"
PROVIDES = "virtual/bootbin"

S = "${WORKDIR}"

do_install () {
	:
}

do_deploy () {
	install ${S}/BOOT.bin ${DEPLOY_DIR_IMAGE}/BOOT.bin
}

addtask deploy before do_build after do_install
