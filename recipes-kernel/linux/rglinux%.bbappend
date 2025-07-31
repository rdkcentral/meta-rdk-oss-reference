FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " file://apparmor.cfg", "" ,d)}"
