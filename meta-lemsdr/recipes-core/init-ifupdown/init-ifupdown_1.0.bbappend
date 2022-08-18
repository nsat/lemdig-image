# LEMSDR layer over init-ifupdown recipe
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Setting up CAN device requires "ip" command contained in iproute2 package, not one
# provided by busybox. Since the "interfaces" script in this LEMDIG-specific recipe
# enables CAN, iproute2 is listed as RDEPENDS of init-ifupdown. Note that specifying
# iproute2 here will replace "ip" and some other commands provided by busybox with
# those provided by iproute2.
RDEPENDS_${PN} += "iproute2"
