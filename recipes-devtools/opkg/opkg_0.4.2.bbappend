FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://opkg-0.4.2-001-rdk-45953.patch"
SRC_URI += "file://multi_thread_installer.patch"
