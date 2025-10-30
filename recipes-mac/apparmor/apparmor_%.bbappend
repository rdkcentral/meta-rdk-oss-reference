do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

DEPENDS:append = " python3"
BBCLASSEXTEND = "native"
DEPENDS:remove = "linux-libc-headers"
