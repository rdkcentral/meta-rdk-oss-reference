FILESEXTRAPATHS_prepend := "${THISDIR}/glib-2.0:"

SRC_URI += " \
           file://0001-glib-gmessages-UTC_glib2_72.patch \
"

RDEPENDS_${PN}-utils += "libelf"


SRC_URI_append = " \
           file://0001-Fix-passing-NULL-to-g_task_get_cancellable.patch \
           file://CVE-2023-32665_2.72.3_fix.patch \
           "

