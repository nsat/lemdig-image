# Simple initramfs image. Mostly used for live images.
DESCRIPTION = "Small image capable of booting a device. The kernel includes \
the Minimal RAM-based Initial Root Filesystem (initramfs), which finds the \
first 'init' program more efficiently."


INITRAMFS_SCRIPTS ?= "\
                      initramfs-framework-base \
                      initramfs-module-udev \
                      initramfs-module-rootfs \
                     "

PACKAGE_INSTALL = " \
    ${INITRAMFS_SCRIPTS} \
    ${VIRTUAL-RUNTIME_base-utils} \
    udev \
    base-passwd \
    mtd-utils \
    mtd-utils-ubifs \
    ${ROOTFS_BOOTSTRAP_INSTALL} \
"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = "\
    allow-empty-password \
    empty-root-password \
    "

export IMAGE_BASENAME = "${MLPREFIX}${PN}"
IMAGE_LINGUAS = ""

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
inherit core-image

IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

BAD_RECOMMENDATIONS += "busybox-syslog"
