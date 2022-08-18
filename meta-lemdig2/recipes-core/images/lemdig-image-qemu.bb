DESCRIPTION = "Spire LEMDIG 2.0 image for QEMU"

# Override default IMAGE_BOOT_FILES
IMAGE_BOOT_FILES = "fitImage-lemdig-image-initramfs-${MACHINE}.bin;fitImage BOOT.bin"

# QEMU / SD image build onfiguration
IMAGE_CLASSES += "image-types-xilinx-qemu"
IMAGE_FSTYPES = "wic.qemu-sd"

# Add device-trees for QEMU
EXTRA_IMAGEDEPENDS += "  \
        qemu-devicetrees \
"

# This machine has a QEMU model, runqemu setup:
IMAGE_CLASSES += "qemuboot-xilinx"

# Remove NAND/UBIFS mounts from fstab as QEMU doesn't support these
ROOTFS_POSTPROCESS_COMMAND += 'remove_prog_data_mounts_from_fstab; '
remove_prog_data_mounts_from_fstab () {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i '/^.*\/media\/nand1_prog.*/d' ${IMAGE_ROOTFS}${sysconfdir}/fstab
        sed -i '/^.*\/media\/nand2_data.*/d' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}

require recipes-core/images/lemdig-image.inc
