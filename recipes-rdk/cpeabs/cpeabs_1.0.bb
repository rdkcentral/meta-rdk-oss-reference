SUMMARY = "cpeabs library"
HOMEPAGE = "https://github.com/xmidt-org/cpeabs"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSES/Apache-2.0.txt;md5=c846ebb396f8b174b10ded4771514fcc"

DEPENDS = "cjson msgpack-c rbus wdmp-c cimplog"

SRCREV = "d65eeed35dbdacefc6c07b0360038a8148d89d39"
SRC_URI = "git://github.com/xmidt-org/cpeabs.git;nobranch=1;protocol=https"

PV = "git+${SRCPV}"

ASNEEDED = ""

inherit pkgconfig cmake

EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

LDFLAGS += "-lcjson -lmsgpackc -lwdmp-c -lcimplog -lrbus"

CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'WanFailOverSupportEnable', ' -DWAN_FAILOVER_SUPPORTED ', ' ', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'mqttCM', '-DFEATURE_SUPPORT_MQTTCM', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'OneStack', ' -D_ONESTACK_PRODUCT_REQ_', '', d)}"
CFLAGS:append = " \
        -DBUILD_YOCTO \
        -I${STAGING_INCDIR}/cjson \
        -I${STAGING_INCDIR}/rbus \
        -I${STAGING_INCDIR}/rtmessage \
        -I${STAGING_INCDIR}/wdmp-c \
        -I${STAGING_INCDIR}/cimplog \
        -fPIC \
        "
CFLAGS:append = " -Wno-format-truncation -Wno-sizeof-pointer-memaccess"

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"

ASNEEDED:hybrid = ""
ASNEEDED:client = ""
