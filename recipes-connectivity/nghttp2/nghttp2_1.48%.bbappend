FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2026-27135_nghttp2_1.48.0_fix.patch \
"
