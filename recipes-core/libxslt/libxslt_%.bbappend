FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

inherit ptest

RDEPENDS:${PN}-ptest += "bash libxslt-bin libxml2 diffutils coreutils perl"

do_compile_ptest() {
    # libxslt 1.1.35 tests use xsltproc for transformations
    # No compilation required - tests are XSLT stylesheets
    bbnote "libxslt 1.1.35 tests use xsltproc, no compilation required"
}

do_install_ptest() {
    # Install all test files from the tests directory
    # This includes XSLT stylesheets, XML data files, and expected output files
    if [ -d "${S}/tests" ]; then
        cp -r ${S}/tests ${D}${PTEST_PATH}/
    else
        bbwarn "Tests directory not found at ${S}/tests"
    fi

    # Copy any additional test support files
    if [ -f "${S}/xsltproc/testThreads" ]; then
        install -d ${D}${PTEST_PATH}/xsltproc
        install -m 755 ${S}/xsltproc/testThreads ${D}${PTEST_PATH}/xsltproc/
    fi
}

FILES:${PN}-ptest += "${PTEST_PATH}/*"
