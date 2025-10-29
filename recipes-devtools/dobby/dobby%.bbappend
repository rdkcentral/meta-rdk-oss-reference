
do_install:append() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${S}/daemon/process/dobby.service ${D}${systemd_unitdir}/system/
}
FILES:${PN} += "${systemd_unitdir}/*"
