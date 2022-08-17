DESCRIPTION = "Spire LEMDIG 2.0 complete bootstrap image"

IMAGE_FEATURES_remove = "empty-root-password"
# Override default IMAGE_BOOT_FILES
IMAGE_BOOT_FILES = "fitImage-lemdig-image-initramfs-${MACHINE}.bin;fitImage BOOT.bin"
IMAGE_FSTYPES = "wic"

# Ensure WIC SD card image creation is run after any content of the boot partition is changed.
do_image_wic[depends] += " \
    virtual/kernel:do_deploy \
    virtual/bootbin:do_deploy \
    "

# Keep update-rc.d in rootfs
ROOTFS_RO_UNNEEDED_remove = "update-rc.d"

require recipes-core/images/lemdig-image.inc
IMAGE_INSTALL += " lemdig-sd-complete"
