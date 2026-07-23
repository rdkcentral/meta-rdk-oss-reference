FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://CVE-2018-25032_fix.patch \
             file://CVE-2022-37434_fix.patch \
             file://CVE-2023-45853_fix.patch \
"

INSANE_SKIP:${PN}-ptest += "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' ldflags', '', d)}"

# OE6 wrynose: [build-deps] make is runtime-only for ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
