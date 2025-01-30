FILESEXTRAPATHS_prepend:="${THISDIR}/${PN}:"
SRC_URI_append = " file://CVE-2022-27404_fix.patch \
                   file://CVE-2022-27405_fix.patch \
                   file://CVE-2022-27406_fix.patch "

PACKAGECONFIG:append = " brotli"
PACKAGECONFIG[brotli] = "--with-brotli,--without-brotli,brotli"
