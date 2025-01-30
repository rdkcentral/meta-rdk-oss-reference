FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://CVE-2022-43680_fix.patch \
                 "
