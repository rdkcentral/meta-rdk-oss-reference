SUMMARY = "C implementation of the WebPA client library"
HOMEPAGE = "https://github.com/Comcast/libparodus"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

DEPENDS = "cjson nopoll wrp-c wdmp-c trower-base64 nanomsg msgpack-c"

SRCREV = "8263bb06c8c16dc114c800a3d29d0c8252f15619"
SRC_URI = "git://github.com/Comcast/libparodus.git;nobranch=1;protocol=https"
PV = "git+${SRCPV}"


ASNEEDED = ""
inherit pkgconfig cmake

CFLAGS:append = " \
    -I${STAGING_INCDIR} \
    -I${STAGING_INCDIR}/cjson \
    -I${STAGING_INCDIR}/nopoll \
    -I${STAGING_INCDIR}/wdmp-c \
    -I${STAGING_INCDIR}/wrp-c \
    -I${STAGING_INCDIR}/nanomsg \
    -I${STAGING_INCDIR}/trower-base64 \
    "

EXTRA_OECMAKE += "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"
