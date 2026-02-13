FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit ptest

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    oe_runmake -C ${B}/tests test_atomic test_atomic_generalized test_stack test_malloc
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests
    install -m 0755 ${B}/tests/test_atomic ${D}${PTEST_PATH}/tests/
    install -m 0755 ${B}/tests/test_atomic_generalized ${D}${PTEST_PATH}/tests/
    install -m 0755 ${B}/tests/test_stack ${D}${PTEST_PATH}/tests/
    install -m 0755 ${B}/tests/test_malloc ${D}${PTEST_PATH}/tests/
    if [ -f ${B}/tests/test_atomic_pthreads ]; then
        install -m 0755 ${B}/tests/test_atomic_pthreads ${D}${PTEST_PATH}/tests/
    fi
}

RDEPENDS:${PN}-ptest += "bash"
