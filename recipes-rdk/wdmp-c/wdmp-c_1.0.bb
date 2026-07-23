SUMMARY = "C library for WebPA Data Model Parser (WDMP)"
HOMEPAGE = "https://github.com/Comcast/wdmp-c"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

DEPENDS = "cjson cimplog"

SRCREV = "c7e00d1f159ef8609e7789430d18508fb39d66d3"
SRC_URI = "git://github.com/xmidt-org/wdmp-c.git;nobranch=1;protocol=https"
PV = "git+${SRCPV}"


inherit pkgconfig cmake

EXTRA_OECMAKE += "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

LDFLAGS += "-lm"

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"
