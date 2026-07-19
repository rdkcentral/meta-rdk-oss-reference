SUMMARY = "Essos is a library making it simple to create applications that run either as native EGL or Wayland clients."

include westeros.inc

LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=7df5a8706277b586ca000838046993d1"

SRC_URI = "${ESSOS_URI}"

SRCREV_FORMAT = "essos"

S = "${WORKDIR}/git"

DEPENDS = "wayland virtual/egl libxkbcommon essosrmgr westeros"
RDEPENDS:${PN}-dev += "essosrmgr-dev"

DEBIAN_NOAUTONAME:${PN} = "1"
DEBIAN_NOAUTONAME:${PN}-dbg = "1"
DEBIAN_NOAUTONAME:${PN}-dev = "1"
DEBIAN_NOAUTONAME:${PN}-staticdev = "1"

REQUIRED_DISTRO_FEATURES += "wayland"

inherit autotools pkgconfig features_check

PACKAGECONFIG ??= "westeros resmgr"
PACKAGECONFIG[westeros] = "--disable-essoswesterosfree,--enable-essoswesterosfree,westeros-simpleshell virtual/westeros-soc"
PACKAGECONFIG[resmgr] = "--disable-essosresmgrfree,--enable-essosresmgrfree"

PACKAGES =+ "${PN}-examples"
FILES:${PN}-examples += "${bindir}/*"
