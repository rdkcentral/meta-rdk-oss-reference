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

PTEST_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', '1', '0', d)}"

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
FILES:${PN} =+ " ${bindir}/c_rehash"
