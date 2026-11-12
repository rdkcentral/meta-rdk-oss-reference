FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Created by CVE pipeline for util-linux 2.37.4
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2026-3184_util-linux_2.37.4_fix.patch \
"
