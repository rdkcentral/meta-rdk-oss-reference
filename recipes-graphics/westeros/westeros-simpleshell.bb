SUMMARY = "This recipe compiles the westeros compositor simple-shell component"

include westeros.inc

S = "${WORKDIR}/git/simpleshell"

SRC_URI = "${WESTEROS_URI}"

DEPENDS = "wayland glib-2.0 wayland-native"

LICENSE_LOCATION = "${S}/../LICENSE"

inherit autotools pkgconfig

do_compile:prepend() {
   export SCANNER_TOOL=${STAGING_BINDIR_NATIVE}/wayland-scanner
   oe_runmake -C ${S}/protocol
}
