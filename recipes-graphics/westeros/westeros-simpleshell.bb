SUMMARY = "This receipe compiles the westeros compositor simple-shell component"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"

S = "${WORKDIR}/git/simpleshell"

SRC_URI = "${RDKCENTRAL_GITHUB_ROOT}/westeros;${RDKCENTRAL_GITHUB_SRC_URI_SUFFIX}"

DEPENDS = "wayland glib-2.0 wayland-native"

LICENSE_LOCATION = "${S}/../LICENSE"

inherit autotools pkgconfig

do_compile:prepend() {
   export SCANNER_TOOL=${STAGING_BINDIR_NATIVE}/wayland-scanner
   oe_runmake -C ${S}/protocol
}
