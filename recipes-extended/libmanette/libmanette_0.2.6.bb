SUMMARY = "The simple GObject game controller library"
HOMEPAGE = "https://gnome.pages.gitlab.gnome.org/libmanette/"
LICENSE = "LGPL-2.1-only & Zlib"
LIC_FILES_CHKSUM = "file://COPYING;md5=4fbd65380cdd255951079008b364516c"
DEPENDS = "libevdev libgudev"
SRC_URI = "https://download.gnome.org/sources/libmanette/0.2/libmanette-${PV}.tar.xz \
           file://0001-old-kernel-and-64-bit-kernel-build-error-fix.patch \
           file://0001-send-event-in-thread-context.patch \
           file://0001-default-gamepad-db-dir-usr-share.patch \
           file://gamecontrollerdb \
           file://0001-new-SDL-gamedb.patch \
           file://0002-add-wayland-inputfd-support.patch \
           file://0001-map-key-menu-back-as-btn.patch \
           file://0003-button-values-for-gas-brake.patch \
           file://0001-nintendo-digital-trigger-dpad-fix.patch \
           "

SRC_URI[sha256sum] = "63653259a821ec7d90d681e52e757e2219d462828c9d74b056a5f53267636bac"

inherit meson pkgconfig gobject-introspection ptest vala

PACKAGECONFIG:append = "wayland-inputfd"
PACKAGECONFIG[wayland-inputfd] = "-Dwayland-inputfd=true,-Dwayland-inputfd=false,wayland wayland-native"

do_install:append() {
    install -d ${D}${datadir}/libmanette/
    cp -f ${WORKDIR}/gamecontrollerdb ${D}${datadir}/libmanette/
    chmod 0644 ${D}${datadir}/libmanette/gamecontrollerdb

    rm ${D}/usr/bin/manette-test
    rmdir --ignore-fail-on-non-empty ${D}/usr/bin/
}

FILES:${PN} += "${datadir}/libmanette/"
#FILES:${PN}-ptest =+ "${bindir}/manette-test"
#FILES:${PN}-ptest =+ "${bindir}/ManetteEventMapping"
#FILES:${PN}-ptest =+ "${bindir}/ManetteMapping"
#FILES:${PN}-ptest =+ "${bindir}/ManetteMappingManager"
#FILES:${PN}-dev =+ "${libdir}/girepository-1.0"
