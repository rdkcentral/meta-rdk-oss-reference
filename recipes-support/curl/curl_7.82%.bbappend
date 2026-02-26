FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}_${PV}:"

SRC_URI:append = " file://ocsp_request_to_CA_Directly_curl_7.82.patch \
                   file://run-ptest \
"

CURLGNUTLS = "--without-gnutls --with-ssl"
DEPENDS += " openssl"

# see https://lists.yoctoproject.org/pipermail/poky/2013-December/009435.html
# We should ideally drop ac_cv_sizeof_off_t from site files but until then
EXTRA_OECONF += "${@bb.utils.contains('DISTRO_FEATURES', 'largefile', 'ac_cv_sizeof_off_t=8', '', d)}"

PACKAGECONFIG:append = " ipv6 "
PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,"

inherit ptest

do_compile_ptest() {
    oe_runmake -C tests
}

# STEP 2: Install everything to the image
do_install_ptest() {
    # 1. Create directory structure
    install -d ${D}${PTEST_PATH}/tests/server
    install -d ${D}${PTEST_PATH}/tests/libtest/.libs
    install -d ${D}${PTEST_PATH}/tests/unit/.libs
    install -d ${D}${PTEST_PATH}/tests/data
    install -d ${D}${PTEST_PATH}/tests/certs
    install -d ${D}${PTEST_PATH}/src

    # 2. Create the symlink for internal verification
    ln -sf /usr/bin/curl ${D}${PTEST_PATH}/src/curl

    # 3. Copy scripts and metadata
    cp -rf ${S}/tests/*.pl ${D}${PTEST_PATH}/tests/
    cp -rf ${S}/tests/*.pm ${D}${PTEST_PATH}/tests/
    cp -rf ${S}/tests/*.py ${D}${PTEST_PATH}/tests/
    cp -rf ${S}/tests/data ${D}${PTEST_PATH}/tests/

    [ -f ${S}/tests/stunnel.conf ] && cp -f ${S}/tests/stunnel.conf ${D}${PTEST_PATH}/tests/
    [ -f ${S}/tests/tgsservice.conf ] && cp -f ${S}/tests/tgsservice.conf ${D}${PTEST_PATH}/tests/

    # Ensure helper scripts in subdirectories are copied
    install -d ${D}${PTEST_PATH}/tests/libtest
    install -m 0755 ${S}/tests/libtest/*.pl ${D}${PTEST_PATH}/tests/libtest/

    for dir in server libtest unit; do
        # Search for the hidden .libs directory and copy real binaries
        if [ -d "${B}/tests/$dir/.libs" ]; then
            cp -f ${B}/tests/$dir/.libs/* ${D}${PTEST_PATH}/tests/$dir/ 2>/dev/null || true
        fi

        # Also grab any built helpers that aren't in .libs, but avoid the shell scripts
        find ${B}/tests/$dir -maxdepth 1 -executable -type f \
            ! -name "lib*" ! -name "unit*" ! -name "*.pl" ! -name "*.sh" \
            -exec cp -f {} ${D}${PTEST_PATH}/tests/$dir/ \; 2>/dev/null || true
    done
    
    # 4. Copy certificates recursively
    if [ -d ${S}/tests/certs ]; then
        cp -rfp ${S}/tests/certs/* ${D}${PTEST_PATH}/tests/certs/
    fi
    
    # Ensure stunnel.pem is present and has correct permissions
    if [ -f ${S}/tests/stunnel.pem ]; then
        install -m 0600 ${S}/tests/stunnel.pem ${D}${PTEST_PATH}/tests/
    fi
    
    install -d ${D}${PTEST_PATH}/tests/log
    chmod 777 ${D}${PTEST_PATH}/tests/log
    chmod -R 755 ${D}${PTEST_PATH}/tests 
    
    # Create data symlink in data directory
    ln -sf . ${D}${PTEST_PATH}/tests/data/data
}

FILES:${PN}-ptest += "${PTEST_PATH}/tests/*"

RDEPENDS:${PN}-ptest += "bash"
