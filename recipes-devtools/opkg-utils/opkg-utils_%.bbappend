inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash opkg-utils"

do_compile_ptest() {
    # No compilation needed
    :
}

do_install_ptest() {
    mkdir -p ${D}${PTEST_PATH}/tests
    cp -r ${S}/tests/* ${D}${PTEST_PATH}/tests/
    # Create opkg-feed symlink in ptest root so tests can access it
    ln -sf ${bindir}/opkg-feed ${D}${PTEST_PATH}/opkg-feed
}

# OE6 wrynose: [build-deps]/[file-rdeps] bash/python3 runtime-only; ptest not in vanilla OE list
INSANE_SKIP:${PN}:append:wrynose = " build-deps file-rdeps"
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
# [missing-ptest] is a QARECIPETEST via oe.qa.handle_error() which checks ERROR_QA, not INSANE_SKIP
ERROR_QA:remove:wrynose = "missing-ptest"
