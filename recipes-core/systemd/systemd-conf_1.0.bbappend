#Disable default journal conf settings.
do_install:append() {
     rm -rf ${D}${systemd_unitdir}/journald.conf.d
}
FILES:${PN}:remove = "${systemd_unitdir}/journald.conf.d/"

