FILESEXTRAPATHS_prepend := "${THISDIR}/dbus:"

SRC_URI_append = " \
    file://dbus_rdk_system_configuration.patch \
"



do_install_append() {
         # Remove <includedir>system.d</includedir> from system.conf since it consumes much CPU cycles for dbus-daemon
         sed -i '/system.d/d' ${D}${sysconfdir}/dbus-1/system.conf
}

inherit breakpad-wrapper
