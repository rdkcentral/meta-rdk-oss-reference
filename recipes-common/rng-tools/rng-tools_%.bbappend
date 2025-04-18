FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
inherit systemd

SRC_URI += "file://rng-tools.service"

do_install:append() {
       install -d ${D}/${systemd_unitdir}/system
       install -m 0644 ${WORKDIR}/rng-tools.service ${D}/${systemd_unitdir}/system
       #Remove rngd.service to avoid package QA issue as we are overriding it with rng-tools.service
       rm -f ${D}/${systemd_unitdir}/system/rngd.service
}

SYSTEMD_SERVICE:${PN} = "rng-tools.service"
FILES:${PN} += "${systemd_unitdir}/system/rng-tools.service"
