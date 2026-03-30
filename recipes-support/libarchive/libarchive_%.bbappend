inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

# Add bsdtar/bsdcpio as sub-packages to resolve dependency these packages are provide by libarchive 3.6.1 but we are removing these as part of cleanup by adding them in packages-extras
# (elfutils-ptest depends on the 'bsdtar' package by name)
PACKAGES =+ "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'bsdtar bsdcpio', '', d)}"
FILES:bsdtar = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '${bindir}/bsdtar', '', d)}"
FILES:bsdcpio = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '${bindir}/bsdcpio', '', d)}"

RDEPENDS:${PN}-ptest += "bash ${PN}"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}
}
