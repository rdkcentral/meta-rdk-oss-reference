SUMMARY = "Stream EDitor (text filtering utility)"
HOMEPAGE = "http://www.gnu.org/software/sed/"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
                    file://sed/sed.h;beginline=1;endline=17;md5=e00ffd1837f298439a214fd197f6a407"
SECTION = "console/utils"
PR = "r7"

SRC_URI = "${GNU_MIRROR}/sed/sed-${PV}.tar.gz \
           file://fix_return_type.patch \
           file://sed-4.1.2_fix_for_automake-1.12.patch \
           file://Makevars \
           file://0001-Fix-builds-with-gettext-0.20.patch \
           "

SRC_URI[md5sum] = "928f0e06422f414091917401f1a834d0"
SRC_URI[sha256sum] = "638e837ba765d5da0a30c98b57c2953cecea96827882f594612acace93ceeeab"

inherit autotools texinfo update-alternatives gettext

do_configure:prepend () {
	cp ${WORKDIR}/Makevars ${S}/po/
}

do_install () {
	autotools_do_install
	install -d ${D}${base_bindir}
	if [ ! ${D}${bindir} -ef ${D}${base_bindir} ]; then
	    mv ${D}${bindir}/sed ${D}${base_bindir}/sed
	    rmdir ${D}${bindir}/
	fi
}

ALTERNATIVE:${PN} = "sed"
ALTERNATIVE_LINK_NAME[sed] = "${base_bindir}/sed"
ALTERNATIVE_PRIORITY = "100"

# sed 4.1.2 ptest support
# Note: sed 4.1.2 uses traditional test structure with runtest script
# (newer versions use gnulib-style tests which are different)

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

inherit ptest

# sed 4.1.2 tests need perl, gawk, and file comparison tools
RDEPENDS:${PN}-ptest += "make perl gawk coreutils diffutils"

do_compile_ptest() {
    # Compile C test programs in testsuite
    # sed 4.1.2 has regex tests written in C
    cd ${B}/testsuite

    # Compile regex test programs if they exist
    for test_src in bug-regex*.c tst-*.c; do
        if [ -f "${S}/testsuite/$test_src" ]; then
            test_bin="${test_src%.c}"
            ${CC} ${CFLAGS} ${LDFLAGS} -o $test_bin ${S}/testsuite/$test_src || true
        fi
    done
}

do_install_ptest() {
    # Install entire testsuite directory
    install -d ${D}${PTEST_PATH}/testsuite

    # Copy test data files (.good, .inp, .sed, .sh files)
    install -m 0644 ${S}/testsuite/*.good ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0644 ${S}/testsuite/*.inp ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0644 ${S}/testsuite/*.sed ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0755 ${S}/testsuite/*.sh ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0644 ${S}/testsuite/*.gin ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0644 ${S}/testsuite/*.h ${D}${PTEST_PATH}/testsuite/ || true
    install -m 0644 ${S}/testsuite/*.tests ${D}${PTEST_PATH}/testsuite/ || true

    # Copy C source files (needed by some tests)
    install -m 0644 ${S}/testsuite/*.c ${D}${PTEST_PATH}/testsuite/ || true

    # Install test runner script
    if [ -f "${S}/testsuite/runtest" ]; then
        install -m 0755 ${S}/testsuite/runtest ${D}${PTEST_PATH}/testsuite/
    fi

    # Install compiled test binaries from build directory
    for test_bin in ${B}/testsuite/bug-regex* ${B}/testsuite/tst-*; do
        if [ -f "$test_bin" ] && [ -x "$test_bin" ]; then
            install -m 0755 $test_bin ${D}${PTEST_PATH}/testsuite/ || true
        fi
    done

    # Install Makefile components needed for tests
    install -m 0644 ${S}/testsuite/Makefile.* ${D}${PTEST_PATH}/testsuite/ || true

    # Install sed binary to ptest directory
    install -d ${D}${PTEST_PATH}/bin
    install -m 0755 ${B}/sed/sed ${D}${PTEST_PATH}/bin/sed

    # Substitute PTEST_PATH in run-ptest script
    sed -i -e 's|@PTEST_PATH@|${PTEST_PATH}|g' ${D}${PTEST_PATH}/run-ptest
}
