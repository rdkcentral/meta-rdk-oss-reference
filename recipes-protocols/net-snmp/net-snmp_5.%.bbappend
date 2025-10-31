FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"
CACHED_CONFIGUREVARS = "ac_cv_lib_crypto_EVP_md5=yes ac_cv_lib_crypto_AES_cfb128_encrypt=no"
CACHED_CONFIGUREVARS:append = " ac_cv_file__etc_printcap=no"
RDEPENDS:${PN}:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ssl-1.1.1', ' openssl', '', d)}"

SRC_URI += "file://rdk_enhancement.patch"

SRC_URI:append = " file://systemd-support.patch \
                   file://sd-deamon_h.patch \
                   file://agent_registry.patch \
                 "

SRC_URI:append_broadband = " \
            file://rdkb_snmp.patch \
"

SRC_URI:append_kirkstone = "${@bb.utils.contains('PREFERRED_VERSION_net-snmp', '5.8', 'file://CVE-2022-44792_fix.patch' , ' ', d)}"
