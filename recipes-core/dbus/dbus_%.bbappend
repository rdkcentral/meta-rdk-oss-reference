FILESEXTRAPATHS:prepend := "${THISDIR}/dbus:"

SRC_URI:append = " \
    file://dbus_rdk_system_configuration.patch \
"

SRC_URI:append:broadband = " \
    file://01-dbus-ccsp-apis-1.14.10.patch \
"

#Removed --with-xml expact as the configuration is not supported in 1.14. It was not supported in dunfell version 1.12.16 as well.
EXTRA_OECONF:broadband = "--disable-tests \
                          --disable-xml-docs \
                          --disable-doxygen-docs \
                          --disable-libaudit \
                          --disable-checks \
                          --disable-systemd"


do_install:append() {
         # Remove <includedir>system.d</includedir> from system.conf since it consumes much CPU cycles for dbus-daemon
         sed -i '/system.d/d' ${D}${sysconfdir}/dbus-1/system.conf
}

do_configure:append() {
    sed -i 's/#define DBUS_HAVE_LINUX_EPOLL 1/#undef DBUS_HAVE_LINUX_EPOLL/' ${B}/config.h
}

inherit breakpad-wrapper
