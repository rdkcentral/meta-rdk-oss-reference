FILESEXTRAPATHS:prepend := "${THISDIR}/glib-2.0:"

RDEPENDS:${PN}-utils += "libelf"


SRC_URI:append = " \
           file://0001-Fix-passing-NULL-to-g_task_get_cancellable.patch \
           "
