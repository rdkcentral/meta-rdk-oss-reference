FILESEXTRAPATHS:prepend:="${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2022-36227_fix.patch \
                   file://CVE-2024-48957_fix.patch \
                   file://CVE-2024-48958_fix.patch \
                   file://CVE-2024-26256_3.6.1_fix.patch \
                 "
