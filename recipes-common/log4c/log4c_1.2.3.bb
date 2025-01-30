SUMMARY = "Log4c is a C library for flexible logging to files, syslog and other destinations"
HOMEPAGE = "http://log4c.sourceforge.net"
LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=4fbd65380cdd255951079008b364516c"

SRC_URI = "${SOURCEFORGE_MIRROR}/${BPN}/${BP}.tar.gz"

SRC_URI[md5sum] = "f35264f40c33dc308cff12193583981d"
SRC_URI[sha256sum] = "dcb5e0d9dd3a7a51b91dcd0fe00145521e681f1454f3c3eba159b3a93212ffe0"

SRC_URI:append = " \
	file://04log4c_sizewin.patch \
	file://03log4c_rollingfileapender.patch \
        file://memory-leak-fix-log4c.patch \
"

PACKAGECONFIG ??= ""
PACKAGECONFIG[expat] = "--with-expat,--without-expat,expat"

inherit autotools pkgconfig
