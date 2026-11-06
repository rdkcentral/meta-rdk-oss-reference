FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://CVE-2026-1539_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-2443_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-3633_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-4271_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-5119_libsoup_3.6.5_fix.patch \
"
