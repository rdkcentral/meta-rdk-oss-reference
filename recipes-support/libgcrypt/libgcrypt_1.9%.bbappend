FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
           file://fix-for-minidump-creation.patch \
           "
