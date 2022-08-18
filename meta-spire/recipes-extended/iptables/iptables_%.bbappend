FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
            file://init.iptables \
            file://iptables.rules \
            "

INITSCRIPT_NAME = "iptables"
INITSCRIPT_PARAMS = "defaults 5 70"

inherit update-rc.d

do_install_append() {
    install -m 0755 -d ${D}${sysconfdir}
    install -m 0755 -d ${D}${sysconfdir}/init.d/
    install -m 0755 -d ${D}${sysconfdir}/iptables/
    install -m 0755 ${WORKDIR}/init.iptables ${D}${sysconfdir}/init.d/iptables
    install -m 0755 ${WORKDIR}/iptables.rules ${D}${sysconfdir}/iptables/iptables.rules
}
