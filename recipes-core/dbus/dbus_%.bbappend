FILESEXTRAPATHS:prepend := "${THISDIR}/dbus:"

SRC_URI:append = " \
    file://dbus_rdk_system_configuration.patch \
    file://dbus-abort.patch \
"



do_install:append() {
         # Remove <includedir>system.d</includedir> from system.conf since it consumes much CPU cycles for dbus-daemon
         sed -i '/system.d/d' ${D}${sysconfdir}/dbus-1/system.conf
}

inherit breakpad-wrapper
