FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2025-27113_2.9.14_fix.patch \
                 "
