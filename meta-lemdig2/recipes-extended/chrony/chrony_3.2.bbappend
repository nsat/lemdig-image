FILESEXTRAPATHS_prepend := "${THISDIR}/chrony:"

# The chronyd script uses a few `bash` extensions and hence the dependency
# below.
RDEPENDS_chrony += "\
    bash \
"
