DESCRIPTION = "Spire LEMDIG 2.0 image"

IMAGE_INSTALL = ""

inherit core-image

PACKAGE_INSTALL = ""
IMAGE_BOOT_FILES = "BOOT.bin"
IMAGE_FSTYPES = "wic"

# Ensure WIC SD card image creation is run after any content of the boot partition is changed.
do_image_wic[depends] += " \
    virtual/kernel:do_deploy \
    virtual/bootbin:do_deploy \
    "

# Hack - force QEMU config to be written whenever the WIC SD card image is created.
# Without this, the QEMU config is sometimes not updated to point to the latest image.
do_write_qemuboot_conf[vardeps] += "${WICVARS}"
do_write_qemuboot_conf[file-checksums] += "${WKS_FILE_CHECKSUM}"

# Keep update-rc.d in rootfs
ROOTFS_RO_UNNEEDED_remove = "update-rc.d"
