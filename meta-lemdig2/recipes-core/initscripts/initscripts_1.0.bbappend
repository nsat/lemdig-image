FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://initscripts-populate-volatile-suppress-read-only-rootfs-warnings.patch \
    file://local_init.sh \
    "

do_install_append () {
    # Install an init script that runs all init scripts in /usr/local/etc/init.d
    install -m 0755 ${WORKDIR}/local_init.sh ${D}${sysconfdir}/init.d
    update-rc.d -r ${D} local_init.sh start 90 2 3 4 5 . stop 10 0 1 6 .
}
