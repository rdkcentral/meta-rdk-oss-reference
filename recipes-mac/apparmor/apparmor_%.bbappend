do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

BBCLASSEXTEND = "native"
DEPENDS:remove:class-native = "linux-libc-headers"
PACKAGECONFIG:class-native ?= ""

do_install:append:class-native() {
    install -d ${D}${base_sbindir}
    install -m 0755 ${S}/parser/apparmor_parser ${D}${base_sbindir}/apparmor_parser
}

