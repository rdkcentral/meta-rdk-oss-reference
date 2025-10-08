do_install:append() {
    rm -rf ${D}${systemd_system_unitdir}/apparmor.service

    mv ${D}/sbin/.debug/* ${D}${bindir}/.debug/ || true
    mv ${D}/sbin/apparmor_parser ${D}${sbindir}/ || true
    mv ${D}/lib/apparmor/* ${D}${libdir}/apparmor/ || true
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"


INSANE_SKIP:${PN} += "installed-vs-shipped"
