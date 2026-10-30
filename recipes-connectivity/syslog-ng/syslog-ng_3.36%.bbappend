FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Created by CVE pipeline for syslog-ng 3.36.1
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2024-47619_syslog-ng_3.36.1_fix.patch \
"
