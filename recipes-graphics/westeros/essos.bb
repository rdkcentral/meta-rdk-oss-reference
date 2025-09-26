SUMMARY = "Essos is a library making it simple to create applications that run either as native EGL or Wayland clients."
LICENSE = "Apache-2.0"
LICENSE_LOCATION = "${S}/LICENSE"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"

SRC_URI = "${RDKCENTRAL_GITHUB_ROOT}/essos;${RDKCENTRAL_GITHUB_SRC_URI_SUFFIX}

S = "${WORKDIR}/git"

DEPENDS = "wayland virtual/egl libxkbcommon"

REQUIRED_DISTRO_FEATURES += "wayland"

inherit autotools pkgconfig features_check

PACKAGECONFIG ??= "westeros resmgr"
PACKAGECONFIG[westeros] = "--disable-essoswesterosfree,--enable-essoswesterosfree,westeros-simpleshell virtual/westeros-soc"
PACKAGECONFIG[resmgr] = "--disable-essosresmgrfree,--enable-essosresmgrfree"

PACKAGES =+ "${PN}-examples"
FILES:${PN}-examples += "${bindir}/*"
