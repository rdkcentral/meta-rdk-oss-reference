FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


#SRC_URI += "file://CVE-2022-0891_fix.patch
#SRC_URI += "file://CVE-2022-2869_fix.patch
#SRC_URI += "file://CVE-2022-2868_fix.patch \
#             file://CVE-2022-2867_fix.patch \
#            ${@bb.utils.contains('DISTRO_FEATURES', 'yocto-3.1.15', '', 'file://CVE-2020-35523_fix.patch \
#                                                                         file://CVE-2020-35524_fix.patch', d)} \
#            "

