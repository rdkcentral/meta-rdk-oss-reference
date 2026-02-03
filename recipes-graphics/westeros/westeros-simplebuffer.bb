include westeros.inc

SUMMARY = "This receipe compiles the westeros compositor simple-buffer component"

include westeros.inc

S = "${WORKDIR}/git/simplebuffer"

SRC_URI = "${WESTEROS_URI}"

PV = "1.0+gitr${SRCPV}"
# Tip of westeros master as of Jan 12 2026 Westeros 2.0.0
SRCREV_westeros = "0228f9e85fd0c44b85cf4af532c627dbf3d9b518"

LICENSE_LOCATION = "${S}/../LICENSE"

DEPENDS = "wayland glib-2.0 wayland-native"

inherit autotools pkgconfig

do_compile:prepend() {
   export SCANNER_TOOL=${STAGING_BINDIR_NATIVE}/wayland-scanner
   oe_runmake -C ${S}/protocol
}
