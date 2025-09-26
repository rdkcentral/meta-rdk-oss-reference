
SUMMARY = "This receipe compiles the westeros compositor simple-buffer component"

LICENSE = "Apache-2.0"

S = "${WORKDIR}/git/simplebuffer"

SRC_URI = "${RDKCENTRAL_GITHUB_ROOT}/westeros;${RDKCENTRAL_GITHUB_SRC_URI_SUFFIX}"

LICENSE_LOCATION = "${S}/LICENSE"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"

DEPENDS = "wayland glib-2.0 wayland-native"

inherit autotools pkgconfig

do_compile:prepend() {
   export SCANNER_TOOL=${STAGING_BINDIR_NATIVE}/wayland-scanner
   oe_runmake -C ${S}/protocol
}
