FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://CVE-2023-24329.patch \
           "

SRC_URI:append = " file://CVE-2025-13836_python3_3.10.15_fix.patch \
"
