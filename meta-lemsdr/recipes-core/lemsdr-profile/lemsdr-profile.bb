SUMMARY = "Adds LEMSDR-specific changes to the shell profile"

LICENSE = "CLOSED"

SRC_URI = "file://lemsdr.sh"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/profile.d
	install -m 0755 lemsdr.sh ${D}${sysconfdir}/profile.d/
}
