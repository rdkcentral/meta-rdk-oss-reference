FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://canary-curl-logging.patch', '', d)}"

SRC_URI_remove_dunfell = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://canary-curl-logging.patch', '', d)}"
SRC_URI_append_dunfell = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_canarytool', ' file://canary-curl-7.69.1-logging.patch', '', d)}"
