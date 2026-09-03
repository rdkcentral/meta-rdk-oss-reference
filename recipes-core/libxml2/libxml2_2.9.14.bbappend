FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2025-27113_2.9.14_fix.patch \
                   file://CVE-2025-9714_2.9.14_fix.patch \
                   file://CVE-2025-6021_2.9.14_fix.patch \
                   file://CVE-2025-24928_2.9.14_fix.patch \
                 "
