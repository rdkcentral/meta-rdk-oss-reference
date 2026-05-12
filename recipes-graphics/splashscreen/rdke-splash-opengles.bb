SUMMARY = "RDKE OpenGL ES splash screen (JPEG/PNG)"
DESCRIPTION = "Fullscreen OpenGL ES 2.0 splash screen that displays a JPEG/PNG until a /tmp dismiss file exists."
HOMEPAGE = "https://example.org/rdke-splash-opengles"
SECTION = "graphics"

LICENSE = "Apache-2.0"
# Prefer shipping a LICENSE file in the upstream repo and using file://LICENSE.
# If you rely on Yocto common-licenses instead, point LIC_FILES_CHKSUM at that file.
LIC_FILES_CHKSUM = "file://LICENSE;md5=55f430163ca51aba75e2b8df749147fd"

# Remote source (GitHub)
SRC_URI = "git://github.com/rdkcentral/splashscreen.git;protocol=https;branch=feature/RDKEMW-18408"
SRCREV = "${AUTOREV}"

# Build from the subdirectory that contains this component.
S = "${WORKDIR}/git/rdke_splash_opengles"

inherit cmake pkgconfig systemd

# Build-time deps (names may vary by distro/layer)
# Use the distro's default JPEG provider (often the "jpeg" recipe). Depending
# on libjpeg-turbo can cause packagedata overlaps if your distro already uses
# a different JPEG provider.
DEPENDS += "essos westeros jpeg libpng zlib"

SYSTEMD_SERVICE:${PN} = "rdke_splash.service"

do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/rdke_splash ${D}${bindir}/rdke_splash

    install -m 0755 ${S}/dismiss_splash.sh ${D}${bindir}/dismiss_splash.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/rdke_splash.service ${D}${systemd_system_unitdir}/rdke_splash.service
}

FILES:${PN} += "${bindir}/rdke_splash ${bindir}/dismiss_splash.sh ${systemd_system_unitdir}/rdke_splash.service ${libdir}/systemd/system/rdke_splash.service"

