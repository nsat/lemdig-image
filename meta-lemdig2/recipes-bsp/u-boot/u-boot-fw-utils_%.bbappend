FILESEXTRAPATHS_prepend := "${THISDIR}/configs:${THISDIR}/files:"
SRC_URI += "file://config.cfg \
            file://platform-auto.h \
            file://platform-top.h \
            file://fw_env.config \
            "

do_configure_append () {
    install ${WORKDIR}/platform-auto.h ${S}/include/configs/
    install ${WORKDIR}/platform-top.h ${S}/include/configs/zynqmp_te0803.h
    install ${WORKDIR}/config.cfg ${S}/configs/zynqmp_te0803_defconfig
    install ${WORKDIR}/fw_env.config ${S}/tools/env/
    # Hack to allow compatibility with DTC v1.4.7
    # (see: https://github.com/m01/rock64-arch-linux-build/issues/3#issuecomment-366548503)
    rm -f ${STAGING_DIR_NATIVE}/usr/include/fdt.h
    rm -f ${STAGING_DIR_NATIVE}/usr/include/libfdt.h
    rm -f ${STAGING_DIR_NATIVE}/usr/include/libfdt_env.h
}
