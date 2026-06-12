FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://cert-audit.rules"

do_install:append() {
    install -d ${D}${sysconfdir}/audit
    touch ${D}${sysconfdir}/audit/audit.rules
    cat ${WORKDIR}/cert-audit.rules >> ${D}${sysconfdir}/audit/audit.rules
}
