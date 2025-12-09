FILESEXTRAPATHS:prepend := "${THISDIR}/lighttpd-1.4.74:"

SRC_URI:append = " file://bind_lighttpd-1.4.74.patch"

SYSTEMD_SERVICE:${PN}:broadband = ""
RDEPENDS:${PN} += " \
    lighttpd-module-cgi \
    lighttpd-module-openssl \
        "
FILES:${PN} += "${systemd_system_unitdir}/lighttpd.service"
RDEPENDS:${PN}:remove = "lighttpd-module-fastcgi"
RDEPENDS:${PN}:remove = "lighttpd-module-alias"
