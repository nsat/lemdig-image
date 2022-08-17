require cmake.inc
inherit native

DEPENDS += "bzip2-replacement-native xz-native zlib-native curl-native ncurses-native zstd-native"

SRC_URI += "file://OEToolchainConfig.cmake \
            file://environment.d-cmake.sh \
            file://0001-CMakeDetermineSystem-use-oe-environment-vars-to-load.patch \
            file://0005-Disable-use-of-ext2fs-ext2_fs.h-by-cmake-s-internal-.patch \
            "


B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

CMAKE_EXTRACONF = "\
    -DCMAKE_LIBRARY_PATH=${STAGING_LIBDIR_NATIVE} \
    -DBUILD_CursesDialog=1 \
    -DCMAKE_USE_SYSTEM_LIBRARIES=1 \
    -DCMAKE_USE_SYSTEM_LIBRARY_JSONCPP=0 \
    -DCMAKE_USE_SYSTEM_LIBARCHIVE=0 \
    -DCMAKE_USE_SYSTEM_LIBRARY_LIBARCHIVE=0 \
    -DCMAKE_USE_SYSTEM_LIBRARY_LIBUV=0 \
    -DCMAKE_USE_SYSTEM_LIBRARY_LIBRHASH=0 \
    -DCMAKE_USE_SYSTEM_LIBRARY_EXPAT=0 \
    -DENABLE_ACL=0 -DHAVE_ACL_LIBACL_H=0 \
    -DHAVE_SYS_ACL_H=0 \
"

do_configure () {
	${S}/configure --verbose --prefix=${prefix} -- ${CMAKE_EXTRACONF}
}

do_compile() {
	oe_runmake
}

do_install() {
	oe_runmake 'DESTDIR=${D}' install
}

do_compile[progress] = "percent"
