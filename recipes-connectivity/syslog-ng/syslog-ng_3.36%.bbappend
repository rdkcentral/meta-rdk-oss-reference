FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2024-47619_syslog-ng_3.36.1_fix.patch \
"
