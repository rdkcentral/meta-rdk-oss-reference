do_install:append() {
    rm -rf ${D}${systemd_system_unitdir}/apparmor.service
    # wrynose/usrmerge: apparmor Makefile hardcodes /sbin - move to ${sbindir}
    if [ -f "${D}/sbin/apparmor_parser" ]; then
        install -d ${D}${sbindir}
        mv ${D}/sbin/apparmor_parser ${D}${sbindir}/apparmor_parser
        rmdir ${D}/sbin 2>/dev/null || true
    fi
}
# wrynose: parser is moved to ${sbindir} (/usr/sbin) which is in default FILES; literal /sbin removed
FILES:${PN} += " ${sbindir}/apparmor_parser"
# wrynose/usrmerge: apparmor Makefile hardcodes /lib/apparmor/ - in usrmerge systems /lib -> /usr/lib
INSANE_SKIP:apparmor:append = " usrmerge"
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

BBCLASSEXTEND = "native"
DEPENDS:remove:class-native = "linux-libc-headers"
PACKAGECONFIG:class-native ?= ""
SRC_URI:append:class-native = " file://features "

do_install:append:class-native() {
    install -d ${D}${base_sbindir}
    install -d ${D}${libdir}
    install -m 0755 ${S}/parser/apparmor_parser ${D}${base_sbindir}/apparmor_parser
    install -m 0755 ${UNPACKDIR}/features ${D}${libdir}/features
}
