FILESEXTRAPATHS_prepend := "${THISDIR}/linux-adi:"
SRC_URI_append += " \
    file://add_lemsdr_kernel_config.cfg \
    file://marsupial.patch \
    file://ad9361_adc_clk.patch \
"
