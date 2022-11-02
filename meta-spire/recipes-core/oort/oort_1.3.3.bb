SUMMARY = "OORT agent files"
LICENSE = "CLOSED"

DEPENDS = "zlib"

# override if different
OORT_ARCH = "armv8"

SRC_URI = "https://github.com/nsat/oort-agent/releases/download/v${PV}/${OORT_ARCH}_install-${PV}.tar.gz \
           file://0001-change-path-to-oort-agent-for-lemdig.patch \
           "
SRC_URI[md5sum] = "154a4baabca5bb00223bd6e2a25556e9"
SRC_URI[sha256sum] = "7ba3996fb58ea3ea820888dc3c3169076e2ea9ffc52427a3e9e435ab10f57cd4"


S = "${WORKDIR}/install-${OORT_ARCH}"

FILES_${PN} += "\
    /usr/local/bin/oort-agent \
    "

# skip yocto check for a stripped file because the oort-agent build creates
# a stripped binary
INSANE_SKIP_${PN} += "already-stripped"

# create rc.d symlinks to start at boot
INITSCRIPT_NAME = "oort-agent"
INITSCRIPT_PARAMS = "defaults 60"

inherit update-rc.d

#do_unpack() {
#    tar xzf ${OORT_ARCH}_install-${PV}.tar.gz
#}

do_install() {
    install -d ${D}/usr/bin
    install -m 755 ${S}/oort-agent ${D}/usr/bin/oort-agent

    install -d ${D}${sysconfdir}/init.d
    install -m 755 ${S}/init.d/oort-agent ${D}${sysconfdir}/init.d/oort-agent

    install -d -m 700 ${D}${sysconfdir}/monit.d
    install -m 644 ${S}/monit/monit.agent ${D}${sysconfdir}/monit.d/oort-agent.cfg
}
