SUMMARY = "UPnP framework"
DESCRIPTION = "GUPnP is an elegant, object-oriented open source framework for creating UPnP  devices and control points, written in C using GObject and libsoup. The GUPnP API is intended to be easy to use, efficient and flexible. It provides the same set of features as libupnp, but shields the developer from most of UPnP's internals."
LICENSE = "LGPL-2.0-or-later"

DEPENDS = "e2fsprogs gssdp libsoup-2.4 libxml2"

inherit autotools pkgconfig vala gobject-introspection

# Copy vapigen.m4 so that it doesn't get removed by vala class
# (normally this would be the right thing to do, but in gupnp the vapigen.m4 has only a custom macro)
do_configure:prepend() {
        cp -f ${S}/m4/vapigen.m4 ${S}/m4/vapigen-custom.m4 || true
}

FILES:${PN} = "${libdir}/*.so.*"
FILES:${PN}-dev += "${bindir}/gupnp-binding-tool"


SYSROOT_PREPROCESS_FUNCS += "gupnp_sysroot_preprocess"

gupnp_sysroot_preprocess () {
    install -d ${SYSROOT_DESTDIR}${bindir_crossscripts}/
    install -m 755 ${D}${bindir}/gupnp-binding-tool ${SYSROOT_DESTDIR}${bindir_crossscripts}/
}

