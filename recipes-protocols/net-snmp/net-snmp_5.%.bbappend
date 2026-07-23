FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"
CACHED_CONFIGUREVARS = "ac_cv_lib_crypto_EVP_md5=yes ac_cv_lib_crypto_AES_cfb128_encrypt=no"
CACHED_CONFIGUREVARS:append = " ac_cv_file__etc_printcap=no"
RDEPENDS:${PN}:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ssl-1.1.1', ' openssl', '', d)}"

SRC_URI += "file://rdk_enhancement.patch"

SRC_URI:append = " file://systemd-support.patch \
                   file://sd-deamon_h.patch \
                   file://agent_registry.patch \
                 "

SRC_URI:append:broadband = " \
            file://rdkb_snmp.patch \
"

SRC_URI:append:kirkstone = "${@bb.utils.contains('PREFERRED_VERSION_net-snmp', '5.8', 'file://CVE-2022-44792_fix.patch' , ' ', d)}"

# wrynose OE6: CACHED_CONFIGUREVARS not passed when configure is invoked via make.
# Directly inject the cache variable into the configure script as a shell assignment
# at line 2 so the AC_CHECK_FILE for /etc/printcap sees it as pre-set.
do_configure:prepend:wrynose() {
    if grep -q "ac_cv_file__etc_printcap" "${S}/configure" 2>/dev/null; then
        sed -i '2i ac_cv_file__etc_printcap=no' "${S}/configure"
    fi
}

# wrynose OE6: net-snmp embeds TMPDIR paths in config header/script and .so;
# net-snmp-config script and net-snmp-config-64.h embed build paths by design.
# Use direct package names (not ${PN}) to avoid expansion-order issues.
INSANE_SKIP:net-snmp-dev:append:wrynose = " buildpaths"
INSANE_SKIP:net-snmp-lib-mibs:append:wrynose = " buildpaths"
INSANE_SKIP:net-snmp-ptest:append:wrynose = " buildpaths"
