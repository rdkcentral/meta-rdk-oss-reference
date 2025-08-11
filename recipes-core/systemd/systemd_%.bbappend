FILESEXTRAPATHS:prepend := "${LAYERDIR}/files:"
SRC_URI += "file://recipes-core/systemd/systemd-preset/00-disable-syslog.preset"

do_install:append() {
    install -Dm644 ${WORKDIR}/recipes-core/systemd/systemd-preset/00-disable-syslog.preset \
        ${D}${nonarch_libdir}/systemd/system-preset/00-disable-syslog.preset
}
