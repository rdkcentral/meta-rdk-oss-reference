inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash make perl sed diffutils ${PN}"

do_compile_ptest() {
    # Only build test helper programs, don't run tests yet
    oe_runmake -C ${B}/tests get-mb-cur-max
}

do_install_ptest() {
    mkdir -p ${D}${PTEST_PATH}/tests
    mkdir -p ${D}${PTEST_PATH}/build-aux

    # Copy test scripts and data files
    cp -r ${S}/tests/* ${D}${PTEST_PATH}/tests/

    # Copy built test helpers
    install -m 0755 ${B}/tests/get-mb-cur-max ${D}${PTEST_PATH}/tests/

    # Copy Makefile and test-driver for running tests
    install -m 0644 ${B}/tests/Makefile ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/build-aux/test-driver ${D}${PTEST_PATH}/build-aux/
}
