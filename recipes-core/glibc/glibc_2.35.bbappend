FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#From meta-rdk-ext
FULL_OPTIMIZATION:remove = "-Os"
FULL_OPTIMIZATION:append = "-O2"


SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://size.patch','',d)} "
SRC_URI += "file://memset_neon_rmpld.patch"
