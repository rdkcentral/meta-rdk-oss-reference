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

# OE6 wrynose: [build-deps]/[file-rdeps] bash runtime-only; ptest not in vanilla OE list
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
# [missing-ptest] is a QARECIPETEST via oe.qa.handle_error() which checks ERROR_QA, not INSANE_SKIP
ERROR_QA:remove:wrynose = "missing-ptest"
