FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://CVE-2018-25032_fix.patch \
             file://CVE-2022-37434_fix.patch \
             file://CVE-2023-45853_fix.patch \
             file://0004-zlib-preserve-file-offset-bits-with-time64.patch \
"

INSANE_SKIP:${PN}-ptest += "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' ldflags', '', d)}"
