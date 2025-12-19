do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

#Temporary change, not to be merged on develop. This is due to usrmerge
INSANE_SKIP:${PN} += "usrmerge installed-vs-shipped"
INSANE_SKIP:${PN}-dbg += "usrmerge "
