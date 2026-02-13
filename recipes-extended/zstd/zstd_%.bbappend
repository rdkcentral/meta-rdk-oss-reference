FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit ptest

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    # Build individual test programs (not test targets which try to run tests)
    oe_runmake -C ${S}/tests fullbench fuzzer zstreamtest datagen decodecorpus paramgrill
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests

    # Install test programs
    for prog in fullbench fuzzer zstreamtest datagen decodecorpus paramgrill; do
        if [ -f ${S}/tests/$prog ]; then
            install -m 0755 ${S}/tests/$prog ${D}${PTEST_PATH}/tests/
        fi
    done

    # Copy test scripts and data files
    if [ -d "${S}/tests" ]; then
        cp -rf ${S}/tests/*.sh ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No shell scripts found"
        cp -rf ${S}/tests/golden-* ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No golden files found"
        cp -rf ${S}/tests/dict-files ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No dict-files found"
        cp -f ${S}/tests/Makefile ${D}${PTEST_PATH}/tests/ 2>/dev/null || bbwarn "No Makefile found"
    fi

    # Copy zstd binary from programs directory
    install -d ${D}${PTEST_PATH}/programs
    if [ -f ${S}/programs/zstd ]; then
        install -m 0755 ${S}/programs/zstd ${D}${PTEST_PATH}/programs/
    fi
}

RDEPENDS:${PN}-ptest += "make bash coreutils"
