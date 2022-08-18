SUMMARY = "Adds LEMDIG-specific changes to the shell profile"

LICENSE = "CLOSED"

SRC_URI = "file://lemdig.sh"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/profile.d
	install -m 0755 lemdig.sh ${D}${sysconfdir}/profile.d/
}
