inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}
}

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
NOAUTOPACKAGEDEBUG = "1"

PACKAGES:remove = " \
    ${PN}-doc \
    ${PN}-staticdev \
    ${PN}-dbg \
    ${PN}-dev \
    ${PN}-locale \
    gprofng \
"
EXTRA_OECONF += "--disable-nls"
do_install:append() {
    rm -rf ${D}${datadir}/locale
    rm -rf ${D}${datadir}/info
    rm -rf ${D}${mandir}
    rm -rf ${D}${libdir}/.debug

    rm -rf ${D}${datadir}/locale
    rm -rf ${D}${libdir}/gprofng
    rm -f ${D}${bindir}/*gprofng*
    rm -f ${D}${libdir}/libiberty.a

    rm -rf ${D}${bindir}/.debug
    rm -rf ${D}${libdir}/.debug
    rm -rf ${D}${libdir}/bfd-plugins/.debug
    find ${D} -type d -name .debug -exec rm -rf {} \;

    rm -rf ${D}${includedir}
    rm -f ${D}${sysconfdir}/gprofng.rc

    rm -f ${D}${libdir}/libbfd.so
    rm -f ${D}${libdir}/libopcodes.so
    rm -f ${D}${libdir}/libctf.so
    rm -f ${D}${libdir}/libctf-nobfd.so
    rm -f ${D}${libdir}/libsframe.so
    rm -f ${D}${libdir}/libgprofng.so
}
FILES:${PN} += "/etc"
FILES:${PN} += "/usr/share/"

INSANE_SKIP += "installed-vs-shipped"
