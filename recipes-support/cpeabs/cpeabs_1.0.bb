SUMMARY = "cpeabs library"
HOMEPAGE = "https://github.com/xmidt-org/cpeabs"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSES/Apache-2.0.txt;md5=c846ebb396f8b174b10ded4771514fcc"

DEPENDS = "cjson msgpack-c rbus wdmp-c cimplog"

SRCREV = "b6d23c11a808453e802cd7f21975cfdf3227b9ec"

SRC_URI = "git://github.com/xmidt-org/cpeabs.git"

PV = "git+${SRCPV}"

S = "${UNPACKDIR}/${PN}-${PV}"

ASNEEDED = ""

inherit pkgconfig cmake

EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

LDFLAGS += "-lcjson -lmsgpack-c -lwdmp-c -lcimplog -lrbus"

CFLAGS:append = " ${@bb.utils.contains("DISTRO_FEATURES", "WanFailOverSupportEnable", " -DWAN_FAILOVER_SUPPORTED ", " ", d)} "

CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'mqttCM', '-DFEATURE_SUPPORT_MQTTCM', '', d)}"

CFLAGS:append = " \
        -DBUILD_YOCTO \
        -I${STAGING_INCDIR}/cjson \
        -I${STAGING_INCDIR}/rbus \
        -I${STAGING_INCDIR}/rtmessage \
        -I${STAGING_INCDIR}/wdmp-c \ 
        -I${STAGING_INCDIR}/cimplog \
        -fPIC \
        "
CFLAGS:append_dunfell = " -Wno-format-truncation -Wno-sizeof-pointer-memaccess"

# The libcpeabs.so shared lib isn't versioned, so force the .so file into the
# run-time package (and keep it out of the -dev package).

FILES_SOLIBSDEV = ""
FILES:${PN} += "${libdir}/*.so"

ASNEEDED_hybrid = ""
ASNEEDED_client = ""
