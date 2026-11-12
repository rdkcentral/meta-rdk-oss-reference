FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Created by CVE pipeline for nghttp2 1.48.0
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2026-27135_nghttp2_1.48.0_fix.patch \
"
