FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://cert-audit.rules \
    file://audit-rules-reload.service \
"

inherit systemd

do_install:append() {
    install -d ${D}${sysconfdir}/audit
    touch ${D}${sysconfdir}/audit/audit.rules
    cat ${WORKDIR}/cert-audit.rules >> ${D}${sysconfdir}/audit/audit.rules

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/audit-rules-reload.service \
        ${D}${systemd_system_unitdir}/audit-rules-reload.service

    # Install systemd preset to ensure service is enabled after factory reset
    install -d ${D}${systemd_unitdir}/system-preset
    echo "enable audit-rules-reload.service" > ${D}${systemd_unitdir}/system-preset/90-audit-rules-reload.preset
}

FILES:${PN} += "${systemd_system_unitdir}/audit-rules-reload.service"
FILES:${PN} += "${systemd_unitdir}/system-preset/90-audit-rules-reload.preset"

SYSTEMD_SERVICE:${PN} += "audit-rules-reload.service"
SYSTEMD_AUTO_ENABLE:${PN} := "enable"
