inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash ncurses-tools ncurses-terminfo-base"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}
}
