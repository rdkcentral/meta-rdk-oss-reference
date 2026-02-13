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
    install -m 0755 ${S}/tests/playTests.sh ${D}${PTEST_PATH}/tests/ || true
    cp -rf ${S}/tests/*.sh ${D}${PTEST_PATH}/tests/ || true
    cp -rf ${S}/tests/golden-* ${D}${PTEST_PATH}/tests/ || true
    cp -rf ${S}/tests/dict-files ${D}${PTEST_PATH}/tests/ || true
    cp -f ${S}/tests/Makefile ${D}${PTEST_PATH}/tests/ || true

    # Copy zstd binary from programs directory
    install -d ${D}${PTEST_PATH}/programs
    if [ -f ${S}/programs/zstd ]; then
        install -m 0755 ${S}/programs/zstd ${D}${PTEST_PATH}/programs/
    fi
}

RDEPENDS:${PN}-ptest += "make bash coreutils"
