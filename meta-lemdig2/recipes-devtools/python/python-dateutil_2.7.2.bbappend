FILESEXTRAPATHS_prepend := "${THISDIR}/python-dateutil_2.7.2:"

SRC_URI += "\
  file://setup.py.ptch \
"

do_configure_append () {
    patch -d ${WORKDIR} -p1 < ${WORKDIR}/setup.py.ptch
}

