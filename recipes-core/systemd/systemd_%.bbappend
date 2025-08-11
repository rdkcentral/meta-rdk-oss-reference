FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://00-disable-syslog.preset"

do_install:append() {
    install -D -m 0644 ${WORKDIR}/00-disable-syslog.preset ${D}${sysconfdir}/systemd/system-preset/00-disable-syslog.preset
}
