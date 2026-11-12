FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://CVE-2018-25032_fix.patch \
             file://CVE-2022-37434_fix.patch \
             file://CVE-2023-45853_fix.patch \
"

# zlib's gzguts.h undefines _FILE_OFFSET_BITS before including libc headers.
# Keep the lib32 build from enabling time64 without that file-offset mode.
CFLAGS:append:virtclass-multilib-lib32 = " -U_TIME_BITS"

INSANE_SKIP:${PN}-ptest += "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' ldflags', '', d)}"
