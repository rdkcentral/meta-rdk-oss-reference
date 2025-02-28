FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2023-45145_7.0.4_fix.patch"
