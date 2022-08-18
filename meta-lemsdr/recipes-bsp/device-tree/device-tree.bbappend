FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://system-user.dtsi \
            file://pl.dtsi \
            file://pcw.dtsi \
            file://system-conf.dtsi \
            file://zynqmp.dtsi \
            file://zynqmp-clk-ccf.dtsi \
            file://device_tree_patch.dtsi \
            file://zynqmp-te0803.dts"

COMPATIBLE_MACHINE = "\
te0803-zynqmp|\
marsupial-zynqmp\
"

FILESEXTRAPATHS_prepend := "${THISDIR}/files/te0803-zynqmp:"

DEVICETREE_FLAGS += " --symbols"
