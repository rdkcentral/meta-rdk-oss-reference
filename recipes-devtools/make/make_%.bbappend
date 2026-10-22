inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash perl ${PN}"

do_compile_ptest() {
    # No compilation needed for test scripts
    :
}

do_install_ptest() {
    mkdir -p ${D}${PTEST_PATH}/tests
    cp -r ${S}/tests/* ${D}${PTEST_PATH}/tests/
    # Install make binary to tests directory for the test harness
    ln -sf ${bindir}/make ${D}${PTEST_PATH}/make
}
