FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += " file://CVE-2025-46394_1.35_fix.patch \
           "

SRC_URI:append:kirkstone = " file://CVE-2025-60876_busybox_1.35.0_fix.patch \
"
