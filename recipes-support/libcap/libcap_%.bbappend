inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    # No compilation needed - we'll use the installed binaries
    :
}

do_install_ptest() {
    # Install the run-ptest script
    install -D -m 0755 ${UNPACKDIR}/run-ptest ${D}${PTEST_PATH}/run-ptest
}

RDEPENDS:${PN}-ptest += "bash libcap-bin"
