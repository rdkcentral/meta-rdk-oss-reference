include westeros.inc

SUMMARY = "Essos is a library making it simple to create applications that run either as native EGL or Wayland clients."
LICENSE = "Apache-2.0"
LICENSE_LOCATION = "${S}/LICENSE"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"
SRC_URI = "git://github.com/rdkcentral/essos;protocol=https;nobranch=1"

PV = "1.0+gitr${SRCPV}"
# Tip of westeros master as of Jan 12 2026 Westeros 2.0.0
SRCREV_westeros = "f1c893419a8f2387d995ef56bbad7072b4d80337"
S = "${WORKDIR}/git"
DEPENDS = "wayland virtual/egl libxkbcommon essosrmgr westeros"
DEBIAN_NOAUTONAME:${PN} = "1"
REQUIRED_DISTRO_FEATURES += "wayland"
RDEPENDS:${PN}-dev += "essosrmgr-dev"
inherit autotools pkgconfig features_check

PACKAGECONFIG ??= "westeros resmgr"
PACKAGECONFIG[westeros] = "--disable-essoswesterosfree,--enable-essoswesterosfree,westeros-simpleshell virtual/westeros-soc"
PACKAGECONFIG[resmgr] = "--disable-essosresmgrfree,--enable-essosresmgrfree"

PACKAGES =+ "${PN}-examples"
FILES:${PN}-examples += "${bindir}/*"
