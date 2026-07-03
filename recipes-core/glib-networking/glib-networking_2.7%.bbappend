FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PROVIDES += "glib-openssl"
RPROVIDES:${PN} += "glib-openssl"
