FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://canary-curl-logging-kirkstone-7.82.0.patch', '', d)}"

