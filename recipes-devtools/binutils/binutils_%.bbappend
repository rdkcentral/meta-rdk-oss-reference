inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash"

PACKAGE_BEFORE_PN:remove = "libbfd libopcodes"
FILES:libbfd = ""
FILES:libopcodes = ""
RDEPENDS:${PN}:remove:class-target = "libbfd libopcodes"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}
}
