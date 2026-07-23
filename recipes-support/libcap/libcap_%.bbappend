inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    # No compilation needed - we'll use the installed binaries
    :
}

do_install_ptest() {
    # OE6: SRC_URI file:// entries unpack to ${UNPACKDIR}, not ${WORKDIR}
    install -D -m 0755 ${UNPACKDIR}/run-ptest ${D}${PTEST_PATH}/run-ptest
}

RDEPENDS:${PN}-ptest += "bash libcap-bin"

# [build-deps]: bash is a runtime-only dep (script interpreter); DEPENDS is
#   not package-scoped so it cannot be added only for the ptest subpackage.
# [file-rdeps]: bash's /bin/bash interpreter path is not in FILERPROVIDES pkgdata.
# [missing-ptest]: OE6 check requires entry in ptest-packagelists.inc; RDK-specific
#   ptest additions are never in OE-core's list.
# All three are false positives in RDK standalone builds.
INSANE_SKIP:${PN}-ptest += "build-deps file-rdeps missing-ptest"
