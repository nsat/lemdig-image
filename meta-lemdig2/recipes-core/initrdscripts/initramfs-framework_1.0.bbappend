FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Customizes rootfs mount with altroot= and altrootfstype= options, allowing fallback to an alternate
# rootfs in case the primary one fails.
