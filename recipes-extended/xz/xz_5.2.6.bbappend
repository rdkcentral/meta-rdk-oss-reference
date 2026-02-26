# XZ ptest implementation for xz_5.2.6.bb
# Adapted from upstream OE-Core xz_5.4.5 ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:class-target = " \
    file://0001-Update-test-scripts-xz-5.2.6.patch \
    file://run-ptest \
"

inherit ptest

RDEPENDS:${PN}-ptest += "bash file"

do_compile_ptest() {
    # Compile test binaries without running them
    oe_runmake check TESTS=
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests
    
    # Install compiled test executables from .libs directory
    find ${B}/tests/.libs -type f -executable -exec cp {} ${D}${PTEST_PATH}/tests \;
    
    # Install config.h (needed for some tests)
    cp ${B}/config.h ${D}${PTEST_PATH}
    
    # Install test data files and shell scripts
    for i in files xzgrep_expected_output test_files.sh test_scripts.sh test_compress.sh; do
        if [ -e ${S}/tests/$i ]; then
            cp -r ${S}/tests/$i ${D}${PTEST_PATH}/tests
        else
            bbwarn "Test file $i not found in xz 5.2.6 - skipping"
        fi
    done
    
    # FIX: Install compress_prepared_* test data files
    # These are used by test_compress.sh but may not exist in xz 5.2.6
    # Create them if they don't exist in source
    if [ ! -e ${S}/tests/compress_prepared_abc ]; then
        bbwarn "compress_prepared_* files not found in source, creating minimal test data"
        
        # Create minimal test data files in the install directory
        echo "abcdefghijklmnopqrstuvwxyz" > ${D}${PTEST_PATH}/tests/compress_prepared_abc
        echo "ABCDEFGHIJKLMNOPQRSTUVWXYZ" >> ${D}${PTEST_PATH}/tests/compress_prepared_abc
        
        # Create deterministic pseudo-random data for reproducible builds
        # Using a fixed pattern repeated to generate predictable test data
        yes "0123456789abcdefghijklmnopqrstuvwxyz" | head -c 10240 > ${D}${PTEST_PATH}/tests/compress_prepared_random
        
        cat > ${D}${PTEST_PATH}/tests/compress_prepared_text << 'EOF'
This is a test file for XZ compression testing.
It contains multiple lines of text.
Some lines are repeated.
Some lines are repeated.
The quick brown fox jumps over the lazy dog.
EOF
    else
        # Copy from source if they exist
        cp ${S}/tests/compress_prepared_* ${D}${PTEST_PATH}/tests/ 2>/dev/null || true
    fi
}
