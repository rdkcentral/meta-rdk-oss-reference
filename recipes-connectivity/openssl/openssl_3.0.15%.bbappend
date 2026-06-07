FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://CVE-2025-69419_openssl_3.0.15_fix.patch \
"