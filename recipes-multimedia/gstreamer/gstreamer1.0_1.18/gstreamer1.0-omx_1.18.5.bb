SUMMARY = "OpenMAX IL plugins for GStreamer"
DESCRIPTION = "Wraps available OpenMAX IL components and makes them available as standard GStreamer elements."
HOMEPAGE = "http://gstreamer.freedesktop.org/"
SECTION = "multimedia"

LICENSE = "LGPL-2.1-only"
LICENSE_FLAGS = "commercial"
LIC_FILES_CHKSUM = "file://COPYING;md5=4fbd65380cdd255951079008b364516c \
                    file://omx/gstomx.h;beginline=1;endline=21;md5=5c8e1fca32704488e76d2ba9ddfa935f"

SRC_URI = "https://gstreamer.freedesktop.org/src/gst-omx/gst-omx-${PV}.tar.xz"

SRC_URI[sha256sum] = "2cd457c1e8deb1a9b39608048fb36a44f6c9a864a6b6115b1453a32e7be93b42"

S = "${WORKDIR}/gst-omx-${PV}"

DEPENDS = "gstreamer1.0 gstreamer1.0-plugins-base gstreamer1.0-plugins-bad"

inherit meson pkgconfig upstream-version-is-even

CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"

GSTREAMER_1_0_OMX_TARGET ?= "bellagio"
GSTREAMER_1_0_OMX_CORE_NAME ?= "${libdir}/libomxil-bellagio.so.0"

EXTRA_OEMESON += "-Dtarget=${GSTREAMER_1_0_OMX_TARGET}"

python __anonymous () {
    omx_target = d.getVar("GSTREAMER_1_0_OMX_TARGET",False)
    if omx_target in ['generic', 'bellagio']:
        # Bellagio headers are incomplete (they are missing the OMX_VERSION_MAJOR,#
        # OMX_VERSION_MINOR, OMX_VERSION_REVISION, and OMX_VERSION_STEP macros);
        # appending a directory path to gst-omx' internal OpenMAX IL headers fixes this
        d.appendVar("CFLAGS", " -I${S}/omx/openmax")
    elif omx_target == "rpi":
        # Dedicated Raspberry Pi OpenMAX IL support makes this package machine specific
        d.setVar("PACKAGE_ARCH", d.getVar("MACHINE_ARCH"))
}

set_omx_core_name() {
	sed -i -e "s;^core-name=.*;core-name=${GSTREAMER_1_0_OMX_CORE_NAME};" "${D}${sysconfdir}/xdg/gstomx.conf"
}
do_install[postfuncs] += " set_omx_core_name "

FILES:${PN} += "${libdir}/gstreamer-1.0/*.so"
FILES:${PN}-staticdev += "${libdir}/gstreamer-1.0/*.a"

VIRTUAL-RUNTIME_libomxil ?= "libomxil"
RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_libomxil}"
