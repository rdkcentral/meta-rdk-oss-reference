FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://CVE-2026-22796_openssl_3.0.15_fix.patch \
                   file://CVE-2026-28387_openssl_3.0.15_fix.patch \
                   file://CVE-2026-28388_openssl_3.0.15_fix.patch \
                   file://CVE-2026-28389_openssl_3.0.15_fix.patch \
                   file://CVE-2026-28390_openssl_3.0.15_fix.patch \
                   file://CVE-2026-31789_openssl_3.0.15_fix.patch \
                   file://CVE-2026-31790_openssl_3.0.15_fix.patch \
"
