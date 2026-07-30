#PACKAGE_DEBUG_SPLIT_STYLE='debug-without-srcpkg'
PACKAGES:remove = " \
    elfutils-staticdev \
    elfutils-doc \
    elfutils-locale \
    elfutils-locale-de \
    elfutils-locale-en+boldquot \
    elfutils-locale-en+quot \
    elfutils-locale-es \
    elfutils-locale-ja \
    elfutils-locale-pl \
    elfutils-locale-uk \
"
NOAUTOPACKAGEDEBUG = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

do_install:append() {
    rm -rf ${D}${datadir}/locale
    rm -rf ${D}${bindir}/.debug
    rm -rf ${D}/usr/share/man/*
    rm -rf ${D}/usr/share/man/
    rm -rf ${D}${libdir}/libasm.a
    rm -rf ${D}${libdir}/libdw.a
    rm -rf ${D}${libdir}/libelf.a
}
