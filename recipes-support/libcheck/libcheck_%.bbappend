inherit ptest
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://run-ptest"
do_compile_ptest() {
    oe_runmake -C tests buildtest-TESTS
}

# With the Ninja generator (wrynose default via cmake.bbclass OECMAKE_GENERATOR="Ninja"),
# test targets are part of the default 'all' target and are already compiled during
# do_compile. Confirmed from build.ninja:
#   build all: phony lib/all src/all checkmk/all tests/all
#   default all
#   build tests/all: phony tests/check_check tests/check_check_export tests/ex_output \
#       tests/check_nofork tests/check_nofork_teardown tests/check_set_max_msg_size
# The 'buildtest-TESTS' target only exists with the Unix Makefiles generator (kirkstone),
# where it was needed because test targets were excluded from the default 'all'.
# With Ninja, do_compile_ptest is a no-op.
do_compile_ptest:wrynose() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests
    install -d ${D}${PTEST_PATH}/lib
    
    # Install test binaries from .libs directory (actual executables, not wrappers)
    # NOTE: This list must be kept in sync with the binaries executed in run-ptest
    for bin in check_check check_check_export ex_output check_nofork check_nofork_teardown check_set_max_msg_size; do
        if [ -f ${B}/tests/.libs/$bin ]; then
            install -m 0755 ${B}/tests/.libs/$bin ${D}${PTEST_PATH}/tests/
        elif [ -f ${B}/tests/$bin ]; then
            # Fallback if not in .libs
            install -m 0755 ${B}/tests/$bin ${D}${PTEST_PATH}/tests/
        fi
    done

    # Install test scripts with proper error checking
    for script in ${S}/tests/*.sh; do
        if [ -f "$script" ]; then
            install -m 0755 "$script" ${D}${PTEST_PATH}/tests/
        fi
    done

    # Install support files
    if [ -f ${S}/tests/test_output_strings ]; then
        install -m 0644 ${S}/tests/test_output_strings ${D}${PTEST_PATH}/tests/
    fi

    # Install test_vars and fix paths for target execution
    if [ -f ${B}/tests/test_vars ]; then
        install -m 0644 ${B}/tests/test_vars ${D}${PTEST_PATH}/tests/
        # Fix variable assignments (indented inside if-blocks; remove ^ anchor).
        # Also strip any remaining ${TMPDIR} occurrences from autoconf conditionals.
        sed -i \
            -e 's|SRCDIR=.*|SRCDIR="${PTEST_PATH}/tests"|g' \
            -e 's|OBJDIR=.*|OBJDIR="${PTEST_PATH}/tests"|g' \
            -e 's|TOP_SRCDIR=.*|TOP_SRCDIR="${PTEST_PATH}"|g' \
            -e 's|TOP_BUILDDIR=.*|TOP_BUILDDIR="${PTEST_PATH}"|g' \
            -e "s|${TMPDIR}||g" \
            ${D}${PTEST_PATH}/tests/test_vars
    fi

    # Install any XML test definitions
    find ${B}/tests -name "*.xml" -exec cp {} ${D}${PTEST_PATH}/tests/ \; 2>/dev/null || true

    # Install test logs/expected outputs if present
    if [ -d ${S}/tests/expected ]; then
        cp -r ${S}/tests/expected ${D}${PTEST_PATH}/tests/
    fi
}

# Runtime dependencies
RDEPENDS:${PN}-ptest += "bash gawk sed"

# OE6 wrynose: [build-deps] bash/gawk/sed are runtime-only for ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
# OE6 wrynose: [build-deps]/[file-rdeps] perl is runtime-only for checkmk
INSANE_SKIP:checkmk:append:wrynose = " build-deps file-rdeps"
