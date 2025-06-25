# This recipe's intended to provide only the wayland-egl.so and related pkgconfig
# due to the non-standard wayland package delivery from OSS layer.
# Refer: ./common/meta-rdk-oss-reference/recipes-graphics/wayland/wayland_%.bbappend

HOMEPAGE = "http://wayland.freedesktop.org"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://../COPYING;md5=b31d8f53b6aaf2b4985d7dd7810a70d1 \
                    file://../src/wayland-server.c;endline=24;md5=b8e046164a766bb1ede8ba38e9dcd7ce"

DEPENDS = "wayland"
RDEPENDS:${PN} = "wayland"

SRC_URI = "https://wayland.freedesktop.org/releases/wayland-${PV}.tar.xz \
    file://CMakeLists.txt \
    file://wayland-egl.pc.in \
    "
SRC_URI[sha256sum] = "b8a034154c7059772e0fdbd27dbfcda6c732df29cae56a82274f6ec5d7cd8725"

UPSTREAM_CHECK_URI = "https://wayland.freedesktop.org/releases.html"

S = "${WORKDIR}/wayland-${PV}/egl"

PV ?= "1.20.0"
PR ?= "r0"

inherit cmake pkgconfig

do_configure:prepend() {
    cp ${WORKDIR}/CMakeLists.txt ${S}
    cp ${WORKDIR}/wayland-egl.pc.in ${S}
}

