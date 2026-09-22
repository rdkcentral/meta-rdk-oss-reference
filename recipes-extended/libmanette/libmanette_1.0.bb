SUMMARY = "The simple GObject game controller library"
HOMEPAGE = "https://gnome.pages.gitlab.gnome.org/libmanette/"
LICENSE = "LGPL-2.1-only & Zlib"
LIC_FILES_CHKSUM = "file://COPYING;md5=4fbd65380cdd255951079008b364516c"

# 1.0 adds a HID backend that requires hidapi.
DEPENDS = "libevdev libgudev hidapi"

# 1.0 has no tarball release yet, so build from git at a pinned revision.
PV = "1.0.alpha+git${SRCPV}"
SRCREV = "cf43018293f48c51b1ac4486bdea0e8b0f07ab71"
SRC_URI = "git://gitlab.gnome.org/GNOME/libmanette.git;protocol=https;branch=main \
           file://1.0/0001-glib-272-compat.patch \
           file://1.0/0002-nintendo-joycon-L-R-detect.patch \
           file://1.0/0003-handle-revoked-evdev-devices.patch \
           file://1.0/0004-add-wayland-inputfd-support.patch \
           file://1.0/0005-map-key-menu-back-as-buttons.patch \
           file://1.0/0006-evdev-poll-on-thread-default-context.patch \
           file://1.0/0007-add-rdk-controller-mappings.patch \
           file://1.0/0008-fix-dpad-hat-index.patch \
           file://99-gamepad-set-attr.rules \
           "
S = "${WORKDIR}/git"

# 1.0 needs newer libraries than RDK ships:
#  - hidapi >= 0.13 for the HID backend (hidapi_git.bbappend bumps it to 0.14).
#  - GLib >= 2.76; 0001-glib-272-compat.patch backfills the one call RDK's 2.72
#    lacks.

inherit meson pkgconfig gobject-introspection vala

# Embedded build: no demos or test binaries.
EXTRA_OEMESON = "-Ddemos=false -Dbuild-tests=false -Dinstall-tests=false"

# The WPE web process is sandboxed and receives gamepad fds from the compositor
# over the wp_inputfd protocol instead of opening /dev/input (added by 0004).
PACKAGECONFIG ??= "wayland-inputfd"
PACKAGECONFIG[wayland-inputfd] = "-Dwayland-inputfd=true,-Dwayland-inputfd=false,wayland wayland-native"

# Tag "Joy-Con (R)" so the gudev monitor enumerates it (see 0002).
do_install:append() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-gamepad-set-attr.rules ${D}${sysconfdir}/udev/rules.d/99-gamepad-set-attr.rules
}

FILES:${PN} += "${sysconfdir}/udev/"
