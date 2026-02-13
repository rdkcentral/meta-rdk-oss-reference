FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit ptest

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    # Build the test program
    oe_runmake -C ${B}/tests test
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests
    install -d ${D}${PTEST_PATH}/magic

    # Install test program from build directory
    install -m 0755 ${B}/tests/.libs/test ${D}${PTEST_PATH}/tests/

    # Copy all test files and expected results from source
    if [ -d "${S}/tests" ]; then
        cp -f ${S}/tests/*.testfile ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No .testfile files found"
        cp -f ${S}/tests/*.result ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No .result files found"
        cp -f ${S}/tests/*.magic ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No .magic files found"
    else
        bbwarn "Tests directory not found at ${S}/tests"
    fi

    # Copy magic database from build directory
    if [ -f ${B}/magic/magic.mgc ]; then
        cp -f ${B}/magic/magic.mgc ${D}${PTEST_PATH}/magic/
    fi
}

RDEPENDS:${PN}-ptest += "bash coreutils ${PN}"
