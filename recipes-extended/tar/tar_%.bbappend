ALTERNATIVE_PRIORITY[tar] = "20"

TARGET_CFLAGS:append = "  \
        -Wno-error=incompatible-pointer-types \
        -Wno-error=discarded-qualifiers \
"

PACKAGES = "${PN}"
PACKAGE_DEBUG_SPLIT_STYLE = "debug-without-src"
PACKAGES-LOCALE = ""
ALTERNATIVE:${PN}-rmt = ""
FILES:${PN}-rmt = ""

do_install:append() {
    rm -f ${D}${sbindir}/rmt
    rm -rf ${D}${mandir}
    rm -rf ${D}${infodir}
    rm -rf ${D}${datadir}/locale
}

INSANE_SKIP:${PN} += "installed-vs-shipped"
