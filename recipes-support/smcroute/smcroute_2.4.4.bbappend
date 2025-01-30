
inherit systemd
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Change-config-file-dir-from-etc-to-opt.patch"

do_configure:prepend() {
    export PKG_CONFIG=${STAGING_DIR_NATIVE}${bindir}/pkg-config
}

do_compile:prepend() {
    install -d ${B}/lib
}

do_install:append() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${B}/smcroute.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE:${PN} += "smcroute.service"
