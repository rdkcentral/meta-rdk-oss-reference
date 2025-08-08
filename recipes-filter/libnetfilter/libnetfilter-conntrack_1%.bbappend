FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI:append = " file://bin.patch \
                 "
DEBIAN_NOAUTONAME:${PN} = "1"
