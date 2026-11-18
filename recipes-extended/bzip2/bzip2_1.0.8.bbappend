FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append = " file://CVE-2019-12900_fix.patch "

LICENSE:${PN}-staticdev = "bzip2-1.0.6"
LICENSE:${PN}-locale = "bzip2-1.0.6"
PTEST_ENABLED = "0"
