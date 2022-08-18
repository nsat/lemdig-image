FILESEXTRAPATHS_prepend := "${THISDIR}/configs:"
# Not a typo, need to prevent yocto from applying this patch
SRC_URI += "file://lemsdr_platform.ptch \
            "

do_configure_append () {
    patch -d ${S} -p1 < ${WORKDIR}/lemsdr_platform.ptch
}
