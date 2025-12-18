FILESEXTRAPATHS:prepend := "${THISDIR}/glib-2.0:"

SRC_URI:append:kirkstone += " \
           file://0001-glib-gmessages-UTC_glib2_72.patch \
"

RDEPENDS:${PN}-utils += "libelf"


SRC_URI:append:append:kirkstone = " \
           file://0001-Fix-passing-NULL-to-g_task_get_cancellable.patch \
           file://0001-RDKTV-35445-Fix-localhost-DNS-resolution.patch \
           "

