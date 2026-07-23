FILESEXTRAPATHS:prepend := "${THISDIR}/dbus:"

SRC_URI:append = " \
    file://dbus_rdk_system_configuration.patch \
    file://dbus-abort.patch \
"

SRC_URI:append:broadband = " \
    file://01-dbus-ccsp-apis-${PV}.patch \
    file://02-dbus-mainloop-private-export.patch \
"

#Removed --with-xml expact as the configuration is not supported in 1.14. It was not supported in dunfell version 1.12.16 as well.
EXTRA_OECONF:broadband = "--disable-tests \
                          --disable-xml-docs \
                          --disable-doxygen-docs \
                          --disable-libaudit \
                          --disable-checks \
                          --disable-systemd"

# dbus 1.16.2 uses Meson; EXTRA_OECONF --disable-tests has no effect. Explicitly remove
# the 'tests' PACKAGECONFIG for broadband to honour the intent of disabling tests.
PACKAGECONFIG:remove:broadband = "tests"

# dbus-ptest RDEPENDS on bash/make (runtime test tools) and gnome-desktop-testing (ptest
# runner injected by ptest-gnome.bbclass) -- none of which are build-time deps.
# This is a confirmed false positive for [build-deps] on ptest packages in wrynose/OE6.
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"

do_install:append() {
         # Remove <includedir>system.d</includedir> from system.conf since it consumes much CPU cycles for dbus-daemon
         sed -i '/system.d/d' ${D}${sysconfdir}/dbus-1/system.conf
}

inherit breakpad-wrapper
