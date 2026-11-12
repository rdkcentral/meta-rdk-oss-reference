FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kirkstone = " file://CVE-2023-45145_7.0.4_fix.patch \
                   file://CVE-2023-41056_redis_7.0.13_fix.patch \
                   file://CVE-2025-21605_redis_7.0.13_fix.patch \
                   file://CVE-2026-23631_redis_7.0.13_fix.patch \
"
