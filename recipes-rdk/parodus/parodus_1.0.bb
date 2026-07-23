SUMMARY = "parodus client daemon"
SECTION = "libs"
DESCRIPTION = "C client daemon for parodus"
HOMEPAGE = "https://github.com/Comcast/parodus"

DEPENDS = "cjson nopoll wrp-c wdmp-c trower-base64 nanomsg msgpack-c rdk-logger log4c util-linux cjwt ucresolv curl"
DEPENDS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'seshat', ' libseshat ', ' ', d)}"
DEPENDS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', ' rbus ', ' ', d)}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SRCREV = "9326f2c023c8aeefda57129032b0735201854d58"
SRC_URI = "git://github.com/xmidt-org/parodus.git;nobranch=1;protocol=https"

RDEPENDS:${PN} += "util-linux-uuidgen bash"

PV = "git+${SRCPV}"

ASNEEDED = ""
LDFLAGS += "-lm -llog4c -lrdkloggers -lcjson -lnopoll -lwrp-c -lwdmp-c -lmsgpackc -ltrower-base64 -luuid -lnanomsg -lcjwt -lucresolv -lresolv"
LDFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'seshat', ' -llibseshat ', ' ', d)}"
LDFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', ' -lrbus ', ' ', d)}"

CFLAGS:append = " \
    -I${STAGING_INCDIR} \
    -I${STAGING_INCDIR}/cjson \
    -I${STAGING_INCDIR}/nopoll \
    -I${STAGING_INCDIR}/wdmp-c \
    -I${STAGING_INCDIR}/wrp-c \
    -I${STAGING_INCDIR}/cimplog \
    -I${STAGING_INCDIR}/nanomsg \
    -I${STAGING_INCDIR}/trower-base64 \
    -I${STAGING_INCDIR}/cjwt \
    -I${STAGING_INCDIR}/ucresolv \
    -DFEATURE_DNS_QUERY \
    "
CFLAGS:append = " -DINCLUDE_BREAKPAD "
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'seshat', '-I${STAGING_INCDIR}/libseshat -DENABLE_SESHAT ', ' ', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', '-I${STAGING_INCDIR}/rbus ', ' ', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'parodus_secert', '-DPARODUS_SECERT_ENABLE ', ' ', d)}"
# GCC-15/C23: implicit function declarations are now errors
CFLAGS:append:wrynose = " -Wno-implicit-function-declaration"

inherit pkgconfig cmake
EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true -DFEATURE_DNS_QUERY=true"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'seshat', ' -DENABLE_SESHAT=true', ' ', d)}"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', ' -DENABLE_WEBCFGBIN=true', ' ', d)}"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'WanFailOverSupportEnable', ' -DWAN_FAILOVER_SUPPORTED=true', ' ', d)}"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'parodus_secert', ' -DPARODUS_SECERT_ENABLE=true', ' ', d)}"

do_compile:prepend() {
    # Disable -Werror to handle any GCC 15 compatibility warnings
    sed -i 's/-Werror -Wall/-Wno-error=all/g' ${S}/CMakeLists.txt || true
}

do_install:append() {
    install -d ${D}${sysconfdir}/ssl/certs
    install -m 0644 ${S}/tests/webpa-rs256.pem ${D}${sysconfdir}/ssl/certs
}

FILES:${PN} += " \
        ${bindir}/* \
        ${sysconfdir}/ssl/certs/* \
"
