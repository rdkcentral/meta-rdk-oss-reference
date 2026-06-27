### meta-rdk-comcast #####
EXTRA_OECONF:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'SE05X_ENABLE', "no-hw", "", d)}"
EXTRA_OECONF:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'SE05X-51_ENABLE', "no-hw", "", d)}"
EXTRA_OECONF:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'A5000_ENABLE', "no-hw", "", d)}"

#### meta-rdk-comcast-video  ###########
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Adding patch to fix disable TLS 1.0,1.1 version flag in openssl_3.0.5 version
EXTRA_OECONF += "no-tls1"
EXTRA_OECONF += "no-tls1_1"

SRC_URI:append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://openssl-canary-3.0.5.patch', '', d)}"
SRC_URI:append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd logendpoints', bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://endpoint-logging-canary-enable-3.0.5.patch', 'file://endpoint-logging-canary-disable-3.0.5.patch', d), '', d)}"
SRC_URI:append = " file://pkcs11_migration_support_p12.patch"

DEPENDS:append:class-target = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' systemd', '', d)}"
LDFLAGS =+ "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' -lsystemd ', '', d)}"

inherit syslog-ng-config-gen logrotate_config
SYSLOG-NG_FILTER = "sslendpoint"
SYSLOG-NG_PROGRAM_sslendpoint = "sslendpoint"
SYSLOG-NG_DESTINATION_sslendpoint = "sslendpoints.log"

LOGROTATE_NAME="sslendpoint"
LOGROTATE_LOGNAME_sslendpoint="sslendpoints.log"
#HDD DISABLE
LOGROTATE_SIZE_sslendpoint="204800"
LOGROTATE_ROTATION_sslendpoint="3"
#HDD ENABLE
LOGROTATE_SIZE_MEM_sslendpoint="204800"
LOGROTATE_ROTATION_MEM_sslendpoint="3"



#### meta-rdk-ext openssl_3.0.5 ####
FILESEXTRAPATHS:prepend:="${THISDIR}/${PN}:"

SRC_URI += " file://openssl-c_rehash.sh \
           "

PTEST_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '1', '0', d)}"

#Disable unapproved cipher algorithms
EXTRA_OECONF += "no-camellia"
EXTRA_OECONF += "no-seed"
EXTRA_OECONF += "no-rc5"
EXTRA_OECONF += "no-md2"
#EXTRA_OECONF += "no-md4"
EXTRA_OECONF += "no-mdc2"
EXTRA_OECONF += "no-ssl2"
EXTRA_OECONF += "no-ssl3"
EXTRA_OECONF += "no-err"
EXTRA_OECONF += "no-hw"
#EXTRA_OECONF += "no-srp"
EXTRA_OECONF += "no-idea"
EXTRA_OECONF += "no-rc4"
EXTRA_OECONF += "no-aria"
EXTRA_OECONF += "no-sm4"
EXTRA_OECONF += "no-sm2"


do_install:append () {
        # Install a custom version of c_rehash that can handle sysroots properly.
        # This version is used for example when installing ca-certificates during
        # image creation.
        install -Dm 0755 ${WORKDIR}/openssl-c_rehash.sh ${D}${bindir}/c_rehash
        sed -i -e 's,/etc/openssl,${sysconfdir}/ssl,g' ${D}${bindir}/c_rehash
}

inherit ptest-package-deploy
inherit ptest

do_compile_ptest() {
    if [ ! -d "${B}/test" ]; then
        bbwarn "Test directory not found at ${B}/test"
    fi
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/test
    install -d ${D}${PTEST_PATH}/apps
    install -d ${D}${PTEST_PATH}/util
    install -d ${D}${PTEST_PATH}/engines
    install -d ${D}${PTEST_PATH}/providers

    install -m 644 ${S}/Configure ${D}${PTEST_PATH}/
    install -m 644 ${B}/configdata.pm ${D}${PTEST_PATH}/

    cp -rf ${S}/Configurations ${D}${PTEST_PATH}/
    cp -rf ${S}/external ${D}${PTEST_PATH}/

    ln -sf ${bindir}/openssl ${D}${PTEST_PATH}/apps/openssl

    cd ${S}
    find test/certs test/ct test/d2i-tests test/recipes test/ocsp-tests \
         test/ssl-tests test/smime-certs -type f \
         -exec install -m 644 -D {} ${D}${PTEST_PATH}/{} \;

    find test -name "*.tmpl" -exec install -m 644 -D {} ${D}${PTEST_PATH}/{} \;

    find test -maxdepth 1 -type f \( -name "*.txt" -o -name "*.dat" -o -name "*.bin" \) \
         -exec install -m 644 {} ${D}${PTEST_PATH}/test/ \;

    cd ${S}
    find test -maxdepth 1 -name "*.cnf" -exec install -m 644 {} ${D}${PTEST_PATH}/test/ \;

    bbnote "Verifying critical test configuration files..."
    for cnf_file in test.cnf ca-and-certs.cnf CAtsa.cnf ssl_test_ctx_test.cnf \
                    default.cnf default-and-legacy.cnf default-and-fips.cnf; do
        if [ -f ${D}${PTEST_PATH}/test/${cnf_file} ]; then
            bbnote "  ✓ ${cnf_file} installed"
        elif [ -f ${S}/test/${cnf_file} ]; then
            bbwarn "  ⚠ ${cnf_file} missing, installing now..."
            install -m 644 ${S}/test/${cnf_file} ${D}${PTEST_PATH}/test/${cnf_file}
        else
            bbwarn "  ✗ ${cnf_file} not found in source"
        fi
    done

    if [ -f ${B}/apps/openssl.cnf ]; then
        install -m 644 ${B}/apps/openssl.cnf ${D}${PTEST_PATH}/apps/openssl.cnf
        bbnote "  ✓ apps/openssl.cnf installed"
    else
        bbwarn "  ✗ apps/openssl.cnf not found"
    fi

    cd ${S}
    find test -type f \( -name "*.pem" -o -name "*.der" -o -name "*.key" -o -name "*.req" \) \
         -exec install -m 644 -D {} ${D}${PTEST_PATH}/{} \;

    cd ${S}
    find util -name "*.pl" -o -name "*.pm" \
         -exec install -m 644 -D {} ${D}${PTEST_PATH}/{} \;

    if [ -f ${S}/test/run_tests.pl ]; then
        install -m 755 ${S}/test/run_tests.pl ${D}${PTEST_PATH}/test/
        bbnote "  ✓ test/run_tests.pl installed"
    else
        bbwarn "  ✗ test/run_tests.pl not found - tests may not run!"
    fi

    cd ${S}
    find test -maxdepth 1 -name "*.pl" -exec install -m 755 {} ${D}${PTEST_PATH}/test/ \;
    find test -maxdepth 1 -name "*.sh" -exec install -m 755 {} ${D}${PTEST_PATH}/test/ \; 2>/dev/null || true
    find test/recipes -name "*.pl" -exec install -m 644 -D {} ${D}${PTEST_PATH}/{} \;

    find ${S}/apps -name "*.pl" -exec install -m 644 {} ${D}${PTEST_PATH}/apps/ \; 2>/dev/null || true

    cd ${B}
    find test -type f -name "*[^.]?" -exec install -m 755 -D {} ${D}${PTEST_PATH}/{} \;

    find test -name "*.so" -exec install -m 755 -D {} ${D}${PTEST_PATH}/{} \; 2>/dev/null || true

    cd ${B}
    find util -type f -perm /111 -exec install -m 755 -D {} ${D}${PTEST_PATH}/{} \;

    if [ -d ${B}/providers ]; then
        bbnote "Installing provider libraries..."
        find ${B}/providers -maxdepth 1 -name "*.so" -exec sh -c '
            for file; do
                bbnote "  Installing provider: $(basename $file)"
                install -m 755 "$file" ${D}${PTEST_PATH}/providers/
            done
        ' sh {} +
    else
        bbwarn "  ✗ providers directory not found"
    fi

    LEGACY_FOUND=false

    if [ -f ${B}/providers/legacy.so ]; then
        install -m 755 ${B}/providers/legacy.so ${D}${PTEST_PATH}/providers/
        bbnote "  ✓ legacy.so installed from ${B}/providers/"
        LEGACY_FOUND=true
    elif [ -f ${B}/providers/liblegacy.so ]; then
        install -m 755 ${B}/providers/liblegacy.so ${D}${PTEST_PATH}/providers/legacy.so
        bbnote "  ✓ liblegacy.so installed as legacy.so"
        LEGACY_FOUND=true
    elif [ -f ${D}${libdir}/ossl-modules/legacy.so ]; then
        install -m 755 ${D}${libdir}/ossl-modules/legacy.so ${D}${PTEST_PATH}/providers/
        bbnote "  ✓ legacy.so installed from ${libdir}/ossl-modules/"
        LEGACY_FOUND=true
    fi

    if [ "$LEGACY_FOUND" = "false" ]; then
        bbwarn "=========================================="
        bbwarn "WARNING: legacy.so provider NOT FOUND!"
        bbwarn "  Impact: ~450+ tests will fail"
        bbwarn "  Fix: Ensure PACKAGECONFIG includes 'legacy'"
        bbwarn "=========================================="
    fi

    if [ -d ${B}/engines ]; then
        bbnote "Installing test engines..."
        find ${B}/engines -name "*.so" -exec sh -c '
            for file; do
                bbnote "  Installing engine: $(basename $file)"
                install -m 755 "$file" ${D}${PTEST_PATH}/engines/
            done
        ' sh {} +
    else
        bbwarn "  ✗ engines directory not found"
    fi

    bbnote "Fixing hardcoded paths in installed files..."
    find ${D}${PTEST_PATH} -type f -exec sed -i \
        -e 's,${B},${PTEST_PATH},g' \
        -e 's,${S},${PTEST_PATH},g' \
        {} +

    if [ -f ${D}${PTEST_PATH}/configdata.pm ]; then
        if grep -q "MODULES\.txt'" ${D}${PTEST_PATH}/configdata.pm 2>/dev/null; then
            bbnote "Fixing OpenSSL::fallback MODULES.txt bug in configdata.pm..."
            sed -i "s|/MODULES\.txt'|'|g" ${D}${PTEST_PATH}/configdata.pm
            bbnote "  ✓ Removed /MODULES.txt suffix (now points to directory)"
        fi
    fi

    bbnote "=========================================="
    bbnote "OpenSSL ptest installation summary:"
    bbnote "  Config files: $(find ${D}${PTEST_PATH}/test -name '*.cnf' 2>/dev/null | wc -l)"
    bbnote "  Test data:    $(find ${D}${PTEST_PATH}/test -name '*.txt' -o -name '*.dat' 2>/dev/null | wc -l)"
    bbnote "  Test scripts: $(find ${D}${PTEST_PATH}/test -maxdepth 1 -name '*.pl' 2>/dev/null | wc -l)"
    bbnote "  Test recipes: $(find ${D}${PTEST_PATH}/test/recipes -name '*.t' 2>/dev/null | wc -l)"
    bbnote "  Providers:    $(find ${D}${PTEST_PATH}/providers -name '*.so' 2>/dev/null | wc -l)"
    bbnote "  Engines:      $(find ${D}${PTEST_PATH}/engines -name '*.so' 2>/dev/null | wc -l)"
    bbnote "=========================================="
}

FILES:${PN}-ptest += "${PTEST_PATH}/*"
FILES:${PN} += "${bindir}/c_rehash"

RDEPENDS:${PN}-ptest += "openssl-bin perl perl-modules bash sed openssl-engines openssl-ossl-module-legacy"
RDEPENDS:${PN}-ptest += " \
    perl-module-strict \
    perl-module-warnings \
    perl-module-file-basename \
    perl-module-file-path \
    perl-module-file-spec \
    perl-module-findbin \
    perl-module-getopt-long \
    perl-module-constant \
    perl-module-vars \
    perl-module-lib \
    perl-module-cwd \
    perl-module-exporter \
"

SRC_URI:append = " file://CVE-2025-69419_openssl_3.0.15_fix.patch \
                   file://CVE-2025-69420_openssl_3.0.15_fix.patch \
"
