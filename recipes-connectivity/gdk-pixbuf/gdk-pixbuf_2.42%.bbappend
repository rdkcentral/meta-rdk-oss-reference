FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2026-5201_gdk-pixbuf_2.42.10_fix.patch \
"
