FILESEXTRAPATHS:prepend := "${THISDIR}/glib-2.0:"

SRC_URI += " \
           file://0001-glib-gmessages-UTC_glib2_72.patch \
"

SRC_URI:append = " \
                   file://0001-RDKTV-35445-Fix-localhost-DNS-resolution.patch \
                 "
