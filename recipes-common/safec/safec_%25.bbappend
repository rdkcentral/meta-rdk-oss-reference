COMPATIBLE_HOST .= "|mips.*-linux"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://configure_ac.patch \
    file://hotspot.patch \
    "
EXTRA_OECONF:append = " --disable-wchar"


