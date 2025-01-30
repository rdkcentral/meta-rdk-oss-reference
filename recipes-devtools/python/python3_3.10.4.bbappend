FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://CVE-2021-28861_3.10.4_fix.patch \
            file://CVE-2022-42919_3.10.4_fix.patch \
            file://CVE-2022-45061_3.10.4_fix.patch \
            file://CVE-2023-24329_3.10.4_fix.patch \
           "

