FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
  file://keys/ssh_host_dsa_key  \
  file://keys/ssh_host_dsa_key.pub \
  file://keys/ssh_host_ecdsa_key \
  file://keys/ssh_host_ecdsa_key.pub \
  file://keys/ssh_host_ed25519_key \
  file://keys/ssh_host_ed25519_key.pub \
  file://keys/ssh_host_rsa_key  \
  file://keys/ssh_host_rsa_key.pub \
"

do_install_append () {
    install -m 600 ${S}/../keys/ssh_host_dsa_key            ${D}${sysconfdir}/ssh/
    install -m 644 ${S}/../keys/ssh_host_dsa_key.pub        ${D}${sysconfdir}/ssh/
    install -m 600 ${S}/../keys/ssh_host_ecdsa_key          ${D}${sysconfdir}/ssh/
    install -m 644 ${S}/../keys/ssh_host_ecdsa_key.pub      ${D}${sysconfdir}/ssh/
    install -m 600 ${S}/../keys/ssh_host_ed25519_key        ${D}${sysconfdir}/ssh/
    install -m 644 ${S}/../keys/ssh_host_ed25519_key.pub    ${D}${sysconfdir}/ssh/
    install -m 600 ${S}/../keys/ssh_host_rsa_key            ${D}${sysconfdir}/ssh/
    install -m 644 ${S}/../keys/ssh_host_rsa_key.pub        ${D}${sysconfdir}/ssh/
}

FILES_${PN}-sshd += "${sysconfdir}/ssh/ssh_host*"
