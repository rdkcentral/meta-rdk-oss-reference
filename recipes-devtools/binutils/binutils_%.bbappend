inherit ptest

INCOMPATIBLE_LICENSE_EXCEPTIONS:pn-binutils = "binutils:GPL-3.0-only"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}
}
