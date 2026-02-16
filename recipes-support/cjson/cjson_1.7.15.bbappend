FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


SRC_URI_append = " \
                   file://CVE-2025-57052_1.7.15_fix.patch \
                 "
