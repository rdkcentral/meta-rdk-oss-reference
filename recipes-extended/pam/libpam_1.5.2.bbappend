FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2024-10041_1.5.2_fix.patch \
                 "
