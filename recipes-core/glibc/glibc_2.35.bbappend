FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#From meta-rdk-ext
FULL_OPTIMIZATION:remove = "-Os"
FULL_OPTIMIZATION:append = "-O2"


SRC_URI:append = " file://CVE-2023-0687_2.35_fix.patch \
                   file://CVE-2023-4813_2.35_fix.patch \
                   file://CVE-2023-4911_2.35_fix.patch \
                 "

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://size.patch','',d)} "
