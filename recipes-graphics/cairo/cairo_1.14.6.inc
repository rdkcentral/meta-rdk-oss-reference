SUMMARY = "The Cairo 2D vector graphics library"
DESCRIPTION = "Cairo is a multi-platform library providing anti-aliased \
vector-based rendering for multiple target backends. Paths consist \
of line segments and cubic splines and can be rendered at any width \
with various join and cap styles. All colors may be specified with \
optional translucence (opacity/alpha) and combined using the \
extended Porter/Duff compositing algebra as found in the X Render \
Extension."
HOMEPAGE = "http://cairographics.org"
BUGTRACKER = "http://bugs.freedesktop.org"
SECTION = "libs"

LICENSE = "MPL-1.0 & LGPL-2.1-only & GPL-3.0-or-later"
LICENSE:${PN} = "MPL-1.0 & LGPL-2.1-only"
LICENSE:${PN}-dev = "MPL-1.0 & LGPL-2.1-only"
LICENSE:${PN}-gobject = "MPL-1.0 & LGPL-2.1-only"
LICENSE:${PN}-script-interpreter = "MPL-1.0 & LGPL-2.1-only"
LICENSE:${PN}-perf-utils = "GPL-3.0-or-later"

X11DEPENDS = "virtual/libx11 libsm libxrender libxext"
DEPENDS = "libpng fontconfig pixman glib-2.0 zlib"

PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11 xcb', '', d)} \
           ${@bb.utils.contains('DISTRO_FEATURES', 'directfb', 'directfb', '', d)}"

PACKAGECONFIG[x11] = "--with-x=yes -enable-xlib,--with-x=no --disable-xlib,${X11DEPENDS}"
PACKAGECONFIG[xcb] = "--enable-xcb,--disable-xcb,libxcb"
PACKAGECONFIG[directfb] = "--enable-directfb=yes,,directfb"
PACKAGECONFIG[valgrind] = "--enable-valgrind=yes,--disable-valgrind,valgrind"
PACKAGECONFIG[egl] = "--enable-egl=yes,--disable-egl,virtual/egl"
PACKAGECONFIG[glesv2] = "--enable-glesv2,--disable-glesv2,virtual/libgles2"

#check for TARGET_FPU=soft and inform configure of the result so it can disable some floating points 
require cairo-fpu_1.14.6.inc 
EXTRA_OECONF += "${@get_cairo_fpu_setting(bb, d)} \
                 --enable-tee \
                "

inherit autotools pkgconfig upstream-version-is-even gtk-doc

# We don't depend on binutils so we need to disable this
export ac_cv_lib_bfd_bfd_openr="no"
# Ensure we don't depend on LZO
export ac_cv_lib_lzo2_lzo2a_decompress="no"

BBCLASSEXTEND = "native"
