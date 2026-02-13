FILESEXTRAPATHS:prepend := "${THISDIR}/glib-2.0:"

SRC_URI:append = " \
                   file://0001-RDKTV-35445-Fix-localhost-DNS-resolution.patch \
                 "
