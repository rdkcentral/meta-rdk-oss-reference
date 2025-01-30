do_install_append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE_apparmor_remove = "apparmor.service"
