SUMMARY = "UPnP framework"
DESCRIPTION = "GUPnP is an elegant, object-oriented open source framework for creating UPnP  devices and control points, written in C using GObject and libsoup. The GUPnP API is intended to be easy to use, efficient and flexible. It provides the same set of features as libupnp, but shields the developer from most of UPnP's internals."
LICENSE = "LGPL-2.0-or-later"

DEPENDS = "e2fsprogs gssdp libsoup-2.4 libxml2"

inherit meson pkgconfig vala gobject-introspection

FILES:${PN} = "${libdir}/*.so.*"
FILES:${PN}-dev += "${bindir}/gupnp-binding-tool*"

RDEPENDS:${PN}-dev = "python3 python3-xml"

SYSROOT_PREPROCESS_FUNCS += "gupnp_sysroot_preprocess"

gupnp_sysroot_preprocess () {
    install -d ${SYSROOT_DESTDIR}${bindir_crossscripts}/
    install -m 755 ${D}${bindir}/gupnp-binding-tool* ${SYSROOT_DESTDIR}${bindir_crossscripts}/
}
