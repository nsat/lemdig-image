SUMMARY = "OORT agent files"
LICENSE = "CLOSED"

DEPENDS = "zlib"

# no support for fetching s3 uris
# SRC_URI = "\
#    s3://oort-artifacts/armv7a/install-${PV}.tar.gz \
#    "

# override if different
OORT_ARCH = "cortexa9"

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

do_fetch() {
    aws --profile oort s3 cp s3://oort-artifacts/${OORT_ARCH}/install-${PV}.tar.gz ${WORKDIR}/
}

do_unpack() {
    tar xzf install-${PV}.tar.gz
}

do_install() {
    install -d ${D}/usr/local/bin
    install -m 755 ${S}/oort-agent ${D}/usr/local/bin/oort-agent

    install -d ${D}${sysconfdir}/init.d
    install -m 755 ${S}/init.d/oort-agent ${D}${sysconfdir}/init.d/oort-agent

    install -d ${D}${sysconfdir}/monit.d
    install -m 644 ${S}/monit/monit.agent ${D}${sysconfdir}/monit.d/oort-agent.cfg
}
