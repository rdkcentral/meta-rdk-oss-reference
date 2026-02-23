# GMP ptest implementation

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:class-target = " \
    file://run-ptest \
"

inherit ptest

DEPENDS += "m4-native"
EXTRA_OECONF += " --enable-cxx"

# Compile tests - build test binaries without running them
do_compile_ptest() {
    # Build tests using recursive check target but with empty TESTS list
    # This builds all test binaries in tests/ and subdirectories
    oe_runmake -C ${B}/tests check TESTS="" AM_DEFAULT_VERBOSITY=1 || \
        bbwarn "Some GMP tests may have failed to build"
}

# Install test suite to ptest directory
do_install_ptest() {
    # Create ptest tests directory
    install -d ${D}${PTEST_PATH}/tests/.libs

    # Install test binaries from main tests directory
    for testbin in ${B}/tests/t-*; do
        if [ -f "$testbin" ] && [ -x "$testbin" ]; then
            install -m 0755 "$testbin" ${D}${PTEST_PATH}/tests/.libs/
        fi
    done

    # Install test binaries from tests/.libs if they exist
    if [ -d "${B}/tests/.libs" ]; then
        for testbin in ${B}/tests/.libs/t-*; do
            if [ -f "$testbin" ] && [ -x "$testbin" ]; then
                install -m 0755 "$testbin" ${D}${PTEST_PATH}/tests/.libs/
            fi
        done
    fi

    # Install test binaries from each GMP test subdirectory
    # GMP organizes tests by type: mpz, mpq, mpf, mpn, rand, misc, cxx, devel
    for testdir in mpz mpq mpf mpn rand misc cxx devel; do
        # Check in the subdirectory itself
        for testbin in ${B}/tests/$testdir/t-* ${B}/tests/$testdir/reuse ${B}/tests/$testdir/dive ${B}/tests/$testdir/dive_ui ${B}/tests/$testdir/io ${B}/tests/$testdir/logic ${B}/tests/$testdir/convert; do
            if [ -f "$testbin" ] && [ -x "$testbin" ]; then
                install -m 0755 "$testbin" ${D}${PTEST_PATH}/tests/.libs/ 2>/dev/null || true
            fi
        done

        # Check .libs subdirectory
        if [ -d "${B}/tests/$testdir/.libs" ]; then
            for testbin in ${B}/tests/$testdir/.libs/*; do
                if [ -f "$testbin" ] && [ -x "$testbin" ] && [ ! -h "$testbin" ]; then
                    install -m 0755 "$testbin" ${D}${PTEST_PATH}/tests/.libs/ 2>/dev/null || true
                fi
            done
        fi
    done

    # Verify we installed something
    installed_count=$(find ${D}${PTEST_PATH}/tests/.libs -type f 2>/dev/null | wc -l)
    if [ "$installed_count" -eq 0 ]; then
        bbwarn "No GMP test binaries were installed for ptest!"
    else
        bbnote "Installed $installed_count GMP test binaries for ptest"
    fi
}

RDEPENDS:${PN}-ptest += "bash"
