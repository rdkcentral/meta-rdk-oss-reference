do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

BBCLASSEXTEND = "native"
DEPENDS:remove:class-native = "linux-libc-headers"
PACKAGECONFIG:class-native ?= ""
SRC_URI:append:class-native = " file://features "

do_install:append:class-native() {
    install -d ${D}${base_sbindir}
    install -d ${D}${libdir}
    install -m 0755 ${S}/parser/apparmor_parser ${D}${base_sbindir}/apparmor_parser
    install -m 0755 ${WORKDIR}/features ${D}${libdir}/features
}
