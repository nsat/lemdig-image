# Spire Linux layer over base-files recipe
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " \
    file://95_lemsdr_basefiles \
    file://fstab \
    "

# Add ONI-specific directories in the rootfs
dirs755_append = " \
    /media/sd2 \
    "

do_install_append () {
    # Install additional volatiles configuration file
    install -d ${D}/etc/default/volatiles
    install -m 0644 ${WORKDIR}/95_lemsdr_basefiles ${D}/etc/default/volatiles
    ln -sv nand2_data ${D}/media/sd1
    ln -sv /media/nand2_data/firmware ${D}/lib/firmware
}
