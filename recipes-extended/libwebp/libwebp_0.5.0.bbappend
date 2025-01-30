FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://CVE-2018-25009_fix.patch \
                   file://CVE-2018-25010_25011_fix.patch \
                   file://CVE-2018-25011_fix.patch \
                   file://CVE-2018-25013_fix.patch \
                   file://CVE-2020-36328_fix.patch \
                   file://CVE-2020-36329_fix.patch \
                   file://CVE-2020-36330_fix.patch \
                   file://CVE-2020-36331_fix.patch \
                 "
