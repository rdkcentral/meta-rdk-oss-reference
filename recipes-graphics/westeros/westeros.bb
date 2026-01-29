include westeros.inc
WESTEROS_URI = "git://github.com/rdkcentral/westeros.git;protocol=https;name=westeros"
WESTEROS_SRCREV = "596ccd42f3ae29da6c881cb00fbefbe06e7035ba"
SRC_URI = "${WESTEROS_URI}"
SRCREV_westeros = "${WESTEROS_SRCREV}"
SUMMARY = "This receipe compiles the westeros compositor component"

LICENSE = "Apache-2.0"

PACKAGECONFIG ??= "incapp inctest increndergl incsbprotocol xdgv4"
PACKAGECONFIG[incapp] = "--enable-app=yes"
PACKAGECONFIG[inctest] = "--enable-test=yes"
PACKAGECONFIG[incplayer] = "--enable-player=yes"
PACKAGECONFIG[increndergl] = "--enable-rendergl=yes"
PACKAGECONFIG[incsbprotocol] = "--enable-sbprotocol=yes"
PACKAGECONFIG[incldbprotocol] = "--enable-ldbprotocol=yes"
PACKAGECONFIG[xdgv4] = "--enable-xdgv4=yes"
PACKAGECONFIG[xdgv5] = "--enable-xdgv5=yes"
PACKAGECONFIG[xdgstable] = "--enable-xdgstable=yes"
PACKAGECONFIG[modules] = "--enable-modules=yes,,virtual/westeros-soc"
PACKAGECONFIG[explicit-sync] = "--enable-lexpsyncprotocol=yes, , wayland-protocols"

S = "${WORKDIR}/git"

DEPENDS = "wayland libxkbcommon westeros-simplebuffer westeros-simpleshell virtual/westeros-soc wayland-native"
DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'gstreamer1.0', 'may-not-be-built-without-gstreamer1', d)}"

RDEPENDS:${PN} = "xkeyboard-config"

REQUIRED_DISTRO_FEATURES += "wayland"

inherit autotools pkgconfig features_check

EXTRA_OECONF += "--disable-essos"

do_compile:prepend() {
   export SCANNER_TOOL=${STAGING_BINDIR_NATIVE}/wayland-scanner
   oe_runmake -C ${S}/protocol
   oe_runmake -C ${S}/linux-dmabuf/protocol
   oe_runmake -C ${S}/linux-expsync/protocol
}
