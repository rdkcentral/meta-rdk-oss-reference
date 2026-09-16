SUMMARY = "An HTTP library implementation in C"
DESCRIPTION = "libsoup is an HTTP client/server library for GNOME. It uses GObjects \
and the glib main loop, to integrate well with GNOME applications."
HOMEPAGE = "https://wiki.gnome.org/Projects/libsoup"
BUGTRACKER = "https://bugzilla.gnome.org/"
SECTION = "x11/gnome/libs"
LICENSE = "LGPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=5f30f0716dfdd0d91eb439ebec522ec2"

DEPENDS = "glib-2.0 glib-2.0-native libxml2 sqlite3 libpsl nghttp2"

SHRT_VER = "${@d.getVar('PV').split('.')[0]}.${@d.getVar('PV').split('.')[1]}"

SRC_URI = "${GNOME_MIRROR}/libsoup/${SHRT_VER}/libsoup-${PV}.tar.xz"
SRC_URI[sha256sum] = "51ed0ae06f9d5a40f401ff459e2e5f652f9a510b7730e1359ee66d14d4872740"

SRC_URI += "file://comcast-RDK-56000-Cookie-size-limit-log_3.0.patch"

SRC_URI += "file://0001-http2-set-error-on-zero-return-from-write.patch"
SRC_URI += "file://0002-http2-improve-handling-of-io-error-thrown-early-afte.patch"
SRC_URI += "file://0003-http2-fix-crash-in-on_data_read-after-connection-has.patch"

# Graceful GOAWAY fix, from PR #535 (RDKEMW-23759). Upstream as 6cd90125, which
# landed in 3.7.1, so 3.6.6 still needs it carried. Included here so the 3.6.6
# and 3.7.1 images differ only by libsoup version and not by this fix.
SRC_URI += "file://0005-http2-Fix-requests-failing-with-HTTP-2-Error-NO_ERRO.patch"

# Dropped - upstream in 3.6.6:
#   0004-fix-heap-use-after-free-...  -> 9ba1243a

# kirkstone ships meson 0.61.3 but libsoup >= 3.6.6 requires >= 0.62. Rather
# than upgrade meson-native, which 129 recipes in the distro inherit, drop the
# two things that actually need 0.62:
#
#   1. The meson_version gate itself.
#   2. gir.version() in libsoup/meson.build. ExternalProgram.version() was added
#      in meson 0.62. It only guards passing --doc-format=gi-docgen to
#      g-ir-scanner when g-i >= 1.83.2; we ship 1.72.0 so that branch is never
#      taken, and disabling it leaves the same g-ir-scanner arguments 3.6.5
#      already builds with.
#
# REMOVE BOTH once meson-native is upgraded to >= 0.62.
do_configure:prepend() {
    sed -i "s/meson_version : '>= 0.62'/meson_version : '>= 0.54'/" ${S}/meson.build
    sed -i "s|if gir.version().version_compare('>=1.83.2')|if false|" ${S}/libsoup/meson.build
}

PROVIDES = "libsoup-3.0"
CVE_PRODUCT = "libsoup"

S = "${WORKDIR}/libsoup-${PV}"

inherit meson gettext pkgconfig upstream-version-is-even gobject-introspection

GIR_MESON_ENABLE_FLAG = 'enabled'
GIR_MESON_DISABLE_FLAG = 'disabled'

# libsoup-gnome is entirely deprecated and just stubs in 2.42 onwards. Disable by default.
PACKAGECONFIG ??= ""
PACKAGECONFIG[gssapi] = "-Dgssapi=enabled,-Dgssapi=disabled,krb5"

EXTRA_OEMESON:append = " -Dvapi=disabled -Dtls_check=false"

GIDOCGEN_MESON_OPTION = 'docs'
GIDOCGEN_MESON_ENABLE_FLAG = 'enabled'
GIDOCGEN_MESON_DISABLE_FLAG = 'disabled'

# When built without gnome support, libsoup will contain only one shared lib
# and will therefore become subject to renaming by debian.bbclass. Prevent
# renaming in order to keep the package name consistent regardless of whether
# gnome support is enabled or disabled.
DEBIAN_NOAUTONAME:${PN} = "1"

# glib-networking is needed for SSL, proxies, etc.
RRECOMMENDS:${PN} = "glib-networking"

BBCLASSEXTEND = "native nativesdk"
