# Spire Linux layer over base-files recipe
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add LEMDIG2-specific directories in the rootfs
dirs755_append = " \
    ${LEMDIG_PROG_MOUNTPOINT} \
    ${LEMDIG_DATA_MOUNTPOINT} \
    "

do_install_append () {
    # Link /usr/local to /media/nand1_prog/local to allow storage of local program data to the prog partition.
    ln -sf ${LEMDIG_PROG_MOUNTPOINT}/local ${D}/${prefix}/local
    # Link /etc/timestamp to /usr/local/etc/timestamp to allow loading / saving of the RTC time.
    # See bootmisc.sh in the poky/recipes-core/initscripts recipe for how this is used.
    ln -sf ${LEMDIG_PROG_MOUNTPOINT}/local/etc/timestamp ${D}/${sysconfdir}/timestamp
    # Link /etc/resolv.conf to /var/run/resolv.conf to allow runtime configuration of nameservers
    ln -sf ${D}/var/run/resolv.conf ${D}/${sysconfdir}/resolv.conf
}
