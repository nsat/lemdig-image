FILESEXTRAPATHS_prepend := "${THISDIR}/configs:"
SRC_URI += "file://fw_env.config"

do_configure_append () {
    install ${WORKDIR}/fw_env.config ${S}/tools/env/
}
