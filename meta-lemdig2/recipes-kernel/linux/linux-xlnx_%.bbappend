FILESEXTRAPATHS_prepend := "${THISDIR}/linux-xlnx:"
SRC_URI_append += " \
    file://add_lemdig2_config.cfg \
    file://marsupial.patch \
"
