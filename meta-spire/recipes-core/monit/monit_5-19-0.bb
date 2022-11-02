LICENSE = "GPLv3"

# update this value if changes are made to any of the config files that are not external to Spire
PR = "r2"

RRECOMMENDS_${PN} = "update-rc.d"

SRC_URI = "https://bitbucket.org/tildeslash/monit/get/release-${PV}.tar.gz \
           file://monitrc \
           file://init.monit \
           file://0001-adding-fake-file-to-crete-m4-dir.patch \
           "
S = "${WORKDIR}/tildeslash-monit-f39e9e58bc0c"

SRC_URI[md5sum] = "33f1003983fd9d00e532cd5393c2499d"
SRC_URI[sha256sum] = "0db1ce3a409f35a8c2cddd684875e0d75cf60bde09eeccd0a37296b2c0c246a5"

LIC_FILES_CHKSUM = "file://COPYING;md5=ea116a7defaf0e93b3bb73b2a34a3f51"

INITSCRIPT_NAME = "monit"
INITSCRIPT_PARAMS = "defaults 95 10"

inherit logging 

inherit update-rc.d

inherit autotools-brokensep

EXTRA_OECONF = "--without-pam --without-ssl \
                libmonit_cv_setjmp_available=yes \
                libmonit_cv_vsnprintf_c99_conformant=yes \
               "

# Disable parallel make to avoid race condition in make process (-__-u)
PARALLEL_MAKE = ""

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0600 ${WORKDIR}/monitrc ${D}${sysconfdir}/monitrc
    install -m 0700 -d ${D}${sysconfdir}/monit.d/
    install -m 0755 -d ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/init.monit ${D}${sysconfdir}/init.d/monit
}

CONFFILES_${PN} += "${sysconfdir}/monitrc"
