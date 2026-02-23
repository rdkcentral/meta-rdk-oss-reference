FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://CVE-2021-43618_4.2.1_fix.patch"

# GMP ptest implementation - NO PATCH NEEDED
# GMP 6.2.1 already has correct configure.ac with subdir-objects

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:class-target = " \
    file://run-ptest \
"

inherit ptest

DEPENDS += "m4-native"
EXTRA_OECONF += " --enable-cxx"

# Compile tests - build test binaries without running them
do_compile_ptest() {
    # Build all test binaries using the standard make check target
    # but don't run them (oe_runmake check would try to run them)
    oe_runmake -C ${B}/tests buildtest-TESTS || {
        # If buildtest-TESTS doesn't exist, try building individual test targets
        oe_runmake -C ${B}/tests all
    }
}

# Install test suite to ptest directory
do_install_ptest() {
    # Create ptest tests directory
    install -d ${D}${PTEST_PATH}/tests
    install -d ${D}${PTEST_PATH}/tests/.libs
    
    # Install test binaries from .libs directories
    # GMP organizes tests by component: mpz, mpq, mpf, mpn, misc, cxx, etc.
    find ${B}/tests -name '.libs' -type d | while read libsdir; do
        find $libsdir -name 't-*' -type f -executable -exec install -m 0755 {} ${D}${PTEST_PATH}/tests/.libs/ \;
    done
    
    # Also install top-level test wrapper scripts if they exist
    find ${B}/tests -maxdepth 1 -name 't-*' -type f -executable -exec install -m 0755 {} ${D}${PTEST_PATH}/tests/ \;
}

RDEPENDS:${PN}-ptest += "make bash"

