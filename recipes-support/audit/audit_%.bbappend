FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://cert-audit.rules"

do_install:append() {
    install -d ${D}${sysconfdir}/audit/rules.d
    install -m 0644 ${WORKDIR}/cert-audit.rules \
        ${D}${sysconfdir}/audit/rules.d/cert-audit.rules
}
