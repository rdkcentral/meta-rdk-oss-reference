SUMMARY = "Libav-based GStreamer 1.x plugin"
DESCRIPTION = "Contains a GStreamer plugin for using the encoders, decoders, \
muxers, and demuxers provided by FFmpeg."
HOMEPAGE = "http://gstreamer.freedesktop.org/"
SECTION = "multimedia"

# ffmpeg has comercial license flags so add it as we need ffmpeg as a dependency
LICENSE_FLAGS = "commercial"
LICENSE = "LGPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=6762ed442b3822387a51c92d928ead0d \
                    file://ext/libav/gstav.h;beginline=1;endline=18;md5=a752c35267d8276fd9ca3db6994fca9c \
                    "

SRC_URI = "https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-${PV}.tar.xz"
SRC_URI[sha256sum] = "822e008a910e9dd13aedbdd8dc63fedef4040c0ee2e927bab3112e9de693a548"

S = "${WORKDIR}/gst-libav-${PV}"


CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"


DEPENDS = "gstreamer1.0 gstreamer1.0-plugins-base ffmpeg"

inherit meson pkgconfig upstream-version-is-even

FILES:${PN} += "${libdir}/gstreamer-1.0/*.so"
FILES:${PN}-staticdev += "${libdir}/gstreamer-1.0/*.a"
