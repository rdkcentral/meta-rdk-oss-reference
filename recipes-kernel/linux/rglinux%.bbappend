FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:broadband = " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " file://apparmor.cfg", "" ,d)}"
