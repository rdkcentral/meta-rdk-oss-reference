FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#From meta-rdk-ext
#FULL_OPTIMIZATION:remove = "-Os"
FULL_OPTIMIZATION:append = "-Os"
CFLAGS += "-Wno-format-overflow"


SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://size.patch','',d)} "
