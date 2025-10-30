do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

BBCLASSEXTEND = "native"
DEPENDS:${PN}-native:remove = " linux-libc-headers"
