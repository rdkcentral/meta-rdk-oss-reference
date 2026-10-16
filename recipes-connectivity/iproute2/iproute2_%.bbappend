inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash util-linux ${PN}"

do_compile_ptest() {
    # Build the generate_nlmsg helper directly with proper LDFLAGS for GNU_HASH
    # The upstream Makefile doesn't pass LDFLAGS in its link line, so we compile manually
    cd ${S}
    ${CC} ${CPPFLAGS} ${CFLAGS} -I${S}/include -I${S}/include/uapi \
        -include ${S}/include/uapi/linux/netlink.h \
        ${LDFLAGS} \
        -o ${S}/testsuite/tools/generate_nlmsg \
        ${S}/testsuite/tools/generate_nlmsg.c ${S}/lib/libnetlink.c \
        -lmnl || bbwarn "generate_nlmsg could not be built"
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/testsuite

    # Copy test library
    install -d ${D}${PTEST_PATH}/testsuite/lib
    install -m 0644 ${S}/testsuite/lib/generic.sh ${D}${PTEST_PATH}/testsuite/lib/

    # Copy all test scripts
    cp -r ${S}/testsuite/tests ${D}${PTEST_PATH}/testsuite/

    # Make all .t files executable
    find ${D}${PTEST_PATH}/testsuite/tests -name "*.t" -exec chmod 0755 {} \;

    # Copy generate_nlmsg tool if built
    install -d ${D}${PTEST_PATH}/testsuite/tools
    if [ -f ${S}/testsuite/tools/generate_nlmsg ]; then
        install -m 0755 ${S}/testsuite/tools/generate_nlmsg ${D}${PTEST_PATH}/testsuite/tools/
    fi

    # Copy the ss dump file needed by ssfilter test
    if [ -f ${S}/testsuite/tests/ss/ss1.dump ]; then
        install -m 0644 ${S}/testsuite/tests/ss/ss1.dump ${D}${PTEST_PATH}/testsuite/tests/ss/
    fi
}
