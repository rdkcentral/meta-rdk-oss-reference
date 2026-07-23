# kbd ptest bbappend
# Based on upstream OE-Core implementation by Qiu Tingting
# Adapted for kbd 2.4.0 (only installs directories that exist in this version)

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

inherit ptest

RDEPENDS:${PN}-ptest += "bash"

# The recipe-level LICENSE includes GPL-3.0-or-later (for keymaps-pine).
# Sub-packages dev/staticdev/dbg/ptest only contain GPL-2.0/LGPL-2.0 code;
# set their license explicitly so they don't inherit GPL-3.0 and fail the
# incompatible-license QA check.
LICENSE:${PN}-dev      = "GPL-2.0-or-later & LGPL-2.0-or-later"
LICENSE:${PN}-staticdev = "GPL-2.0-or-later & LGPL-2.0-or-later"
LICENSE:${PN}-dbg      = "GPL-2.0-or-later & LGPL-2.0-or-later"
LICENSE:${PN}-ptest    = "GPL-2.0-or-later & LGPL-2.0-or-later"

# kbd-ptest test binaries embed the source WORKDIR path (DATADIR for test data)
# compiled in; this is expected for ptest binaries and harmless.
INSANE_SKIP:${PN}-ptest:wrynose = "buildpaths"

# kbd-src is added programmatically by package.bbclass anonymous Python
# (prependVar PACKAGES) AFTER PACKAGES:remove runs at parse time, so
# PACKAGES:remove cannot prevent it. Set its license explicitly to compatible
# (kbd-src contains only compiled C debug sources, not the GPL-3.0 keymap data).
LICENSE:${PN}-src:wrynose = "GPL-2.0-or-later & LGPL-2.0-or-later"

# kbd-src, kbd-doc, kbd-locale inherit GPL-3.0-or-later from the recipe-level
# LICENSE; kbd-keymaps-pine IS GPL-3.0. Remove all four to avoid
# incompatible-license QA failure.
# Also remove the RRECOMMENDS from kbd-keymaps on kbd-keymaps-pine so nothing
# requires a package that no longer exists in PACKAGES.
RRECOMMENDS:${PN}-keymaps:remove = "${PN}-keymaps-pine"
PACKAGES:remove = "${PN}-src ${PN}-doc ${PN}-locale ${PN}-keymaps-pine"

# kbd-doc is removed from PACKAGES above, so man pages in ${mandir} are
# unshipped → installed-vs-shipped error. Delete them for wrynose (embedded
# target; man pages are not needed in the image).
do_install:append:wrynose() {
    rm -rf ${D}${mandir}
}

do_compile_ptest() {
    # update DATADIR in Makefile
    sed -i 's,-DDATADIR=.*,-DDATADIR=\\\"${PTEST_PATH}/tests\\\" \\,g' ${B}/tests/libkeymap/Makefile
    sed -i 's,-DDATADIR=.*,-DDATADIR=\\\"${PTEST_PATH}/tests\\\" \\,g' ${B}/tests/helpers/Makefile
    sed -i 's,-DDATADIR=.*,-DDATADIR=\\\"${PTEST_PATH}/tests\\\" \\,g' ${B}/tests/libkbdfile/Makefile

    # recompile tests
    oe_runmake -C ${B}/tests/ clean
    oe_runmake -C ${B}/tests/
}

do_install_ptest() {
    # install test binaries from build directory
    install -d ${D}${PTEST_PATH}/tests/
    install --mode=755 ${B}/tests/testsuite ${D}${PTEST_PATH}/tests/
    
    install -d ${D}${PTEST_PATH}/tests/libkeymap/
    find ${B}/tests/libkeymap/ -type f -not -name "*.o" -not -name "Makefile" \
        -exec install --mode=755 {} ${D}${PTEST_PATH}/tests/libkeymap/ \;
    
    install -d ${D}${PTEST_PATH}/tests/helpers/
    find ${B}/tests/helpers/ -type f -not -name "*.o" -not -name "Makefile" \
        -exec install --mode=755 {} ${D}${PTEST_PATH}/tests/helpers/ \;
    
    install -d ${D}${PTEST_PATH}/tests/libkbdfile/
    find ${B}/tests/libkbdfile/ -type f -not -name "*.o" -not -name "Makefile" \
        -exec install --mode=755 {} ${D}${PTEST_PATH}/tests/libkbdfile/ \;
    
    install -d ${D}${PTEST_PATH}/src/
    install --mode=755 ${B}/src/loadkeys ${D}${PTEST_PATH}/src/

    # install keymap data from src/data directory
    install -d ${D}${PTEST_PATH}/data/keymaps/i386/qwerty/
    install ${S}/data/keymaps/i386/qwerty/defkeymap.map ${D}${PTEST_PATH}/data/keymaps/i386/qwerty/

    # install test data files from src/tests/data directory
    # Note: kbd 2.4.0 has different structure than 2.5.1
    install -d ${D}${PTEST_PATH}/tests/data/
    
    # libkeymap test data
    install -d ${D}${PTEST_PATH}/tests/data/libkeymap/
    install ${S}/tests/data/libkeymap/* ${D}${PTEST_PATH}/tests/data/libkeymap/
    
    # alt-is-meta test data
    install -d ${D}${PTEST_PATH}/tests/data/alt-is-meta/
    install ${S}/tests/data/alt-is-meta/* ${D}${PTEST_PATH}/tests/data/alt-is-meta/
    
    # bkeymap-2.0.4 test data
    install -d ${D}${PTEST_PATH}/tests/data/bkeymap-2.0.4/
    install ${S}/tests/data/bkeymap-2.0.4/* ${D}${PTEST_PATH}/tests/data/bkeymap-2.0.4/
    
    # dumpkeys test data
    install -d ${D}${PTEST_PATH}/tests/data/dumpkeys-mktable/
    install ${S}/tests/data/dumpkeys-mktable/* ${D}${PTEST_PATH}/tests/data/dumpkeys-mktable/
    
    install -d ${D}${PTEST_PATH}/tests/data/dumpkeys-fulltable/
    install ${S}/tests/data/dumpkeys-fulltable/* ${D}${PTEST_PATH}/tests/data/dumpkeys-fulltable/
    
    # findfile test data (complex structure)
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_1/consolefonts/
    install ${S}/tests/data/findfile/test_1/consolefonts/* ${D}${PTEST_PATH}/tests/data/findfile/test_1/consolefonts/
    
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/
    install ${S}/tests/data/findfile/test_0/keymaps/test0.map ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/
    
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/include/
    install ${S}/tests/data/findfile/test_0/keymaps/include/* ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/include/
    
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/include/
    install ${S}/tests/data/findfile/test_0/keymaps/i386/include/* ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/include/
    
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/qwerty/
    install ${S}/tests/data/findfile/test_0/keymaps/i386/qwerty/* ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/qwerty/
    
    install -d ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/qwertz/
    install ${S}/tests/data/findfile/test_0/keymaps/i386/qwertz/* ${D}${PTEST_PATH}/tests/data/findfile/test_0/keymaps/i386/qwertz/

    # Note: kbd 2.4.0 does NOT have tests/data/keymaps/ at top level
    # (that was added in 2.5.x), so we skip those install commands

    # update PTEST_PATH in run-ptest
    sed -i "s#@PTEST_PATH@#${PTEST_PATH}#g" ${D}${PTEST_PATH}/run-ptest
}
