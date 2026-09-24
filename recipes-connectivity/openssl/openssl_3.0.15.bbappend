FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " file://CVE-2025-69419_openssl_3.0.15_fix.patch \
             file://CVE-2025-69420_openssl_3.0.15_fix.patch \
             file://CVE-2025-69421_openssl_3.0.15_fix.patch \
"

SRC_URI:append:kirkstone = " file://CVE-2026-7383_openssl_3.0.15_fix.patch \
                   file://CVE-2026-28387_openssl_3.0.15_fix.patch \
                   file://CVE-2026-31789_openssl_3.0.15_fix.patch \
                   file://CVE-2026-45447_openssl_3.0.15_fix.patch \
"
