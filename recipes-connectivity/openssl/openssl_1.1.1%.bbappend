
## ext ##

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += " file://openssl-c_rehash.sh \
           "

PTEST_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', '1', '0', d)}"

#Disable unapproved cipher algorithms
EXTRA_OECONF += "no-camellia"
EXTRA_OECONF += "no-seed"
EXTRA_OECONF += "no-rc5"
EXTRA_OECONF += "no-md2"
EXTRA_OECONF += "no-md4"
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
FILES:${PN} =+ " ${bindir}/c_rehash"
FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += " file://openssl-c_rehash.sh \
           "

do_install:append () {
        # Install a custom version of c_rehash that can handle sysroots properly.
        # This version is used for example when installing ca-certificates during
        # image creation.
        install -Dm 0755 ${WORKDIR}/openssl-c_rehash.sh ${D}${bindir}/c_rehash
        sed -i -e 's,/etc/openssl,${sysconfdir}/ssl,g' ${D}${bindir}/c_rehash
}
FILES:${PN} =+ " ${bindir}/c_rehash"

## comcast ##

EXTRA_OECONF:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'SE05X_ENABLE', "no-hw", "", d)}"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " file://CVE-2021-4160_fix.patch \
             file://CVE-2022-2097_fix.patch \
             file://CVE-2022-0778_fix.patch \
             file://CVE-2022-1292_fix.patch \
             file://CVE-2022-2068_fix.patch \
             file://CVE-2022-4450_fix_openssl1.1.1l.patch \
             file://CVE-2023-0215_fix_openssl1.1.1l.patch \
             file://CVE-2023-0286_fix_openssl1.1.1l.patch \
"

## comcast-video ##

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://canary-cert-logging.patch', '', d)}"

SRC_URI:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', 'file://canary-cert-logging.patch', '', d)}"
SRC_URI:append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://openssl-canary-3.0.5.patch', '', d)}"
SRC_URI:append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd logendpoints', bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://endpoint-logging-canary-enable-3.0.5.patch', 'file://endpoint-logging-canary-disable-3.0.5.patch', d), '', d)}"

DEPENDS:append:class-target = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' systemd', '', d)}"
LDFLAGS =+ "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' -lsystemd ', '', d)}"

inherit syslog-ng-config-gen
SYSLOG-NG_FILTER = "sslendpoint"
SYSLOG-NG_PROGRAM_sslendpoint = "sslendpoint"
SYSLOG-NG_DESTINATION_sslendpoint = "sslendpoints.log"
# Adding patch to fix disable TLS 1.0,1.1 version flag in openssl_1.1.1 version 
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
EXTRA_OECONF += "no-tls1"
EXTRA_OECONF += "no-tls1_1"
