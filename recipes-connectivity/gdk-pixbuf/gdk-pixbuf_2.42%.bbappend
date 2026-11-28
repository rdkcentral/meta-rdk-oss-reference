FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Created by CVE pipeline for gdk-pixbuf 2.42.10
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2026-5201_gdk-pixbuf_2.42.10_fix.patch \
"
