FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
           file://fix-for-minidump-creation.patch \
           "

PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = " \
    ${bindir}/mpicalc \
"
