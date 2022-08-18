SUMMARY = "Adds LEMDIG images to SD complete image"

LICENSE = "CLOSED"

DEPENDS = " lemdig-image lemdig-image-initramfs"

SRC_URI = "file://flash_filesystem_without_sd_flash.sh"

S = "${WORKDIR}"

FILES_${PN} += " flash_filesystem_without_sd_flash.sh root.ubifs /real_boot/"

#do_install[depends] = " lemdig-image:do_image_complete"

do_install() {
	install -d 0775 ${D}/real_boot/
	install -m 0755 ${S}/flash_filesystem_without_sd_flash.sh ${D}/flash_filesystem_without_sd_flash.sh
	install -m 0755 ${DEPLOY_DIR_IMAGE}/lemdig-image-marsupial-zynqmp.ubifs ${D}/root.ubifs
}
