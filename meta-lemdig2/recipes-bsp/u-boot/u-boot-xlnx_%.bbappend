FILESEXTRAPATHS_prepend := "${THISDIR}/configs:${THISDIR}/files:"
SRC_URI += "file://config.cfg \
            file://platform-auto.h \
            file://platform-top.h \
            "

# This recipe uses a build product of "device-tree" recipe.
DEPENDS += "virtual/dtb"

# The following extra make option is needed to build U-Boot with a custom device tree.
EXTRA_OEMAKE += "EXT_DTB=${S}/dts/zynqmp-te0803.dtb"

# This recipe needs to inherit "deplo" so that do_deploy() (do_deploy_append()) below is actually invoked.
inherit deploy

do_configure_append () {
    install ${WORKDIR}/platform-auto.h ${S}/include/configs/
    install ${WORKDIR}/platform-top.h ${S}/include/configs/zynqmp_te0803.h
    install ${WORKDIR}/config.cfg ${S}/configs/zynqmp_te0803_defconfig
    # Copy Device Tree Blob so that this is imported by U-Boot
    # TODO: Replace the directory path with appropriate environment variable if any exists
    install ${DEPLOY_DIR_IMAGE}/zynqmp-te0803.dtb ${S}/dts/zynqmp-te0803.dtb
    # Hack to allow compatibility with DTC v1.4.7
    # (see: https://github.com/m01/rock64-arch-linux-build/issues/3#issuecomment-366548503)
    rm -f ${STAGING_DIR_NATIVE}/usr/include/fdt.h
    rm -f ${STAGING_DIR_NATIVE}/usr/include/libfdt.h
    rm -f ${STAGING_DIR_NATIVE}/usr/include/libfdt_env.h
}

addtask do_deploy after do_compile before do_build

