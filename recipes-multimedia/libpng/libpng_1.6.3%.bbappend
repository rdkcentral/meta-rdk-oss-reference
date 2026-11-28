FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
        file://libpng-1.6.38-apng.patch \
        "

SRC_URI:append:kirkstone = " file://CVE-2025-66293_libpng_1.6.39_fix.patch \
                   file://CVE-2026-25646_libpng_1.6.39_fix.patch \
                   file://CVE-2026-33416_libpng_1.6.39_fix.patch \
                   file://CVE-2026-33636_libpng_1.6.39_fix.patch \
"
