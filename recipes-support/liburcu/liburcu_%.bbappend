inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash"

do_compile_ptest() {
    oe_runmake -C ${B}/tests/utils
    oe_runmake -C ${B}/tests/unit
    oe_runmake -C ${B}/tests/regression
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/unit
    install -d ${D}${PTEST_PATH}/regression

    # Install unit test binaries
    for t in test_arch test_uatomic test_urcu_multiflavor test_urcu_multiflavor_dynlink \
             test_urcu_multiflavor_single_unit test_urcu_multiflavor_single_unit_dynlink; do
        install -m 0755 ${B}/tests/unit/.libs/$t ${D}${PTEST_PATH}/unit/
    done

    # Install regression test binary (fork test)
    install -m 0755 ${B}/tests/regression/.libs/test_urcu_fork.tap ${D}${PTEST_PATH}/regression/
}
