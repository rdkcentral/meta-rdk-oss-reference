FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2022-28321_1.5.2_fix.patch \
                   file://CVE-2024-22365_1.5.2_fix.patch"
