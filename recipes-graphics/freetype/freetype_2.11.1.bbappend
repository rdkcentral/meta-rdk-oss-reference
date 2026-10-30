FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PACKAGECONFIG:append = " brotli"
PACKAGECONFIG[brotli] = "--with-brotli,--without-brotli,brotli"

SRC_URI:append:kirkstone = " file://CVE-2025-27363_freetype_2.11.1_fix.patch \
"
