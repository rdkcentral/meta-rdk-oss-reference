FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/${PV}:/"

SRC_URI:append = " file://CVE-2022-2868_fix.patch \
                   file://CVE-2022-2869_fix.patch \
"
