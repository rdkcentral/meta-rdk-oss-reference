COMPATIBLE_HOST .= "|mips.*-linux"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://configure_ac.patch \
    file://hotspot.patch \
    "
EXTRA_OECONF:append = " --disable-wchar"



# OE6 wrynose: [build-deps]/[file-rdeps] perl is runtime-only for safec-check (check_for_unsafe_apis)
INSANE_SKIP:${PN}-check:append:wrynose = " build-deps file-rdeps"
