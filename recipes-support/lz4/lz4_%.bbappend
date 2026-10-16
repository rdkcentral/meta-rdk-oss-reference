inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    oe_runmake -C ${S}/tests fullbench datagen roundTripTest checkFrame frametest decompress-partial
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests
    install -m 0755 ${S}/tests/fullbench ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/tests/datagen ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/tests/roundTripTest ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/tests/checkFrame ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/tests/frametest ${D}${PTEST_PATH}/tests/
    install -m 0755 ${S}/tests/decompress-partial ${D}${PTEST_PATH}/tests/
}

RDEPENDS:${PN}-ptest += "bash"
