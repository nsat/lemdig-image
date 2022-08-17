SUMMARY = "OORT agent files"
LICENSE = "CLOSED"

# adds "ARCH" env-var
inherit kernel-arch

# replaces arm64 with armv8
OVERRIDES="${ARCH}"
ALTARCH_arm64 = "armv8"

RDEPENDS_${PN} += "\
	glibc \
	libstdc++ \
	zlib \
	lemur-python-oort \
	"

S = "${WORKDIR}/install-${ALTARCH}"

FILES_${PN} += "\
    ${bindir}/oort-agent \
    "

# skip yocto check for a stripped file because the oort-agent build creates
# a stripped binary
INSANE_SKIP_${PN} += "already-stripped"

# create rc.d symlinks to start at boot
INITSCRIPT_NAME = "oort-agent"
INITSCRIPT_PARAMS = "defaults 60"

inherit update-rc.d

do_fetch() {
    aws --profile oort s3 cp s3://oort-artifacts/${ALTARCH}/install-${PV}.tar.gz ${WORKDIR}/
}

BINDIR_ESCAPED = "${@d.getVar('bindir').replace('/','\/')}"

do_unpack() {
    tar xzf install-${PV}.tar.gz
    # replace the binary path in the init.d script with ${bindir}
    sed -i "s/^CMD=.*/CMD=${BINDIR_ESCAPED}\/oort-agent/" ${S}/init.d/oort-agent
}

do_install() {
    install -D -m 755 ${S}/oort-agent ${D}${bindir}/oort-agent
    install -D -m 755 ${S}/init.d/oort-agent ${D}${sysconfdir}/init.d/oort-agent
}
