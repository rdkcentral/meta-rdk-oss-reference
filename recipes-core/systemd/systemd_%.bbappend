FILESEXTRAPATHS:prepend := "${LAYERDIR}/files:"
SRC_URI += "file://recipes-core/systemd/systemd-preset/00-disable-syslog.preset"

do_install:append() {
install -Dm 0644 ${WORKDIR}/systemd/systemd-preset/00-disable-syslog.preset ${D}${systemd_unitdir}/system-preset/00-disable-syslog.preset
}
