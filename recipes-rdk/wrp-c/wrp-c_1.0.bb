SUMMARY = "C library for Web Routing Protocol (WRP)"
HOMEPAGE = "https://github.com/Comcast/wrp-c"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

DEPENDS = "trower-base64 msgpack-c cimplog"

SRCREV = "9587e8db33dbbfcd9b78ef66cc2eaf16dfb9afcf"
SRC_URI = "git://github.com/xmidt-org/wrp-c.git;nobranch=1;protocol=https"
PV = "git+${SRCPV}"


ASNEEDED = ""

inherit pkgconfig cmake

EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

LDFLAGS += "-lcimplog -lmsgpackc -ltrower-base64"

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"

ASNEEDED:hybrid = ""
ASNEEDED:client = ""
