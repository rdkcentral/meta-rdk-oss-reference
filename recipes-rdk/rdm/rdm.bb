LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "${RDKE_GITHUB_ROOT}/rdm;${RDKE_GITHUB_SRC_URI_SUFFIX};name=rdmgeneric"
SRCREV_rdmgeneric = "2312666a78f60d3bd660f6914986ecfddeaff51c"

SRCREV_FORMAT = "rdmgeneric"
S = "${WORKDIR}/git"

inherit autotools coverity systemd syslog-ng-config-gen
SYSLOG-NG_FILTER = "apps-rdm"
SYSLOG-NG_SERVICE_apps-rdm = "apps-rdm.service"
SYSLOG-NG_DESTINATION_apps-rdm = "rdm_status.log"
SYSLOG-NG_LOGRATE_apps-rdm = "low"

DEPENDS = "curl openssl"
RDEPENDS:${PN}:append = " bash"


INCLUDE_DIRS = " \
    -I${STAGING_INCDIR} \
    -I${STAGING_INCDIR}/openssl \
    "
LDFLAGS += "-ldl -lcrypto -lssl -lcurl -lz"

do_install:append () {
        install -d ${D}${bindir}/
        install -d ${D}${includedir}/rdm/
        install -d ${D}${sysconfdir}
        install -d ${D}${sysconfdir}/rdm/
        install -m644 ${S}/src/rdm_rsa_signature_verify.h ${D}${includedir}/rdm/
        install -m 0755 ${S}/scripts/* ${D}${sysconfdir}/rdm/
        install -m 0600 ${S}/rdm-manifest.json ${D}${sysconfdir}/rdm/

        install -m755 ${WORKDIR}/download_apps.sh ${D}/${bindir}/
        install -m755 ${WORKDIR}/apps_rdm.sh ${D}/${bindir}/
        install -m755 ${WORKDIR}/apps_prerdm.sh ${D}/${bindir}/
        install -m755 ${WORKDIR}/rdm_apps_rfc_check.sh ${D}/${bindir}/
        install -D -m644 ${WORKDIR}/apps-rdm.service ${D}${systemd_unitdir}/system/apps-rdm.service
        install -D -m644 ${WORKDIR}/apps_rdm.path ${D}${systemd_unitdir}/system/apps_rdm.path
        install -D -m644 ${WORKDIR}/apps-prerdm.service ${D}${systemd_unitdir}/system/apps-prerdm.service

        rm -f ${D}${sysconfdir}/rdm/kmsVerify.sh
}

SYSTEMD_SERVICE:${PN} = "apps-rdm.service"
SYSTEMD_SERVICE:${PN} += "apps_rdm.path"
SYSTEMD_SERVICE:${PN} += "apps-prerdm.service"

FILES:${PN} += "${systemd_unitdir}/system/apps-rdm.service"
FILES:${PN} += "${systemd_unitdir}/system/apps_rdm.path"
FILES:${PN} += "${systemd_unitdir}/system/apps-prerdm.service"

FILES:${PN} += " \
                /etc/rdm/* \
                /usr/bin/opensslVerify \
"
