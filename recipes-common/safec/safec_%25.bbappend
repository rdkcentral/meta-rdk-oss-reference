COMPATIBLE_HOST .= "|mips.*-linux"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://configure_ac.patch \
    file://hotspot.patch \
    "
SRC_URI:append = " file://safe_compile_h.patch"
SRC_URI:remove = " file://safe_compile_h.patch"
EXTRA_OECONF:append = " --disable-wchar"


