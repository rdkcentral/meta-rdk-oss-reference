FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2026-3184_util-linux_2.37.4_fix.patch \
"
