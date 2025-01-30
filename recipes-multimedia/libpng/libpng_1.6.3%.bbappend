FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
        file://libpng-1.6.38-apng.patch \
        "
