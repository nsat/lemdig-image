PR = "r1"

LICENSE = "CLOSED"

SRC_URI = "file://authorized_keys \
          "

S = "${WORKDIR}"

USER="root"

# Install list of authorized keys ONLY, no private key

do_install() {
        install -d ${D}/home/${USER}/.ssh/
        install -m 0600 ${S}/authorized_keys ${D}/home/${USER}/.ssh/authorized_keys
}

FILES_${PN} += "/home/${USER}/.ssh/*"
