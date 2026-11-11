inherit ptest
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://run-ptest"

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
        sed -i 's|${S}/tests|${PTEST_PATH}/tests|g' \
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
