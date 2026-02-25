inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

# opkg-feed requires bash 4.0+ for associative arrays (declare -A)
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
