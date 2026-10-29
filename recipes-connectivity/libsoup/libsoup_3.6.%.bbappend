FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Created by CVE pipeline for libsoup 3.6.5
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2026-1539_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-2443_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-2708_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-3633_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-4271_libsoup_3.6.5_fix.patch \
                   file://CVE-2026-5119_libsoup_3.6.5_fix.patch \
"
