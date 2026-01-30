LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=1d13a8bfca16dbdad01fe5f270451aaa \
                    file://LICENSE;md5=1d13a8bfca16dbdad01fe5f270451aaa"

SRC_URI = "https://code.rdkcentral.com/r/rdk/components/generic/ermgr;branch=rdk-next"

S = "${WORKDIR}/git"

DEPENDS = "wayland libgles-eabihf-dvalin-wayland-drm libxkbcommon"

# inherit line
inherit pkgconfig autotools

# Specify any options you want to pass to the configure script using EXTRA_OECONF:
EXTRA_OECONF = ""

RPROVIDES:${PN} = "ermgr"
RREPLACES:${PN} = "ermgr"
RCONFLICTS:${PN} = "ermgr"

#acpaths = "-I cfg"

do_install:append() {

   install -d ${D}${systemd_unitdir}/system
   install -m 0644 ${S}/conf/ermgr.service ${D}${systemd_unitdir}/system

   if ${@bb.utils.contains('DISTRO_FEATURES', 'use_westeros_essrmgr_uds', 'true', 'false', d)}; then
       sed -i "/^Before=/ s/ audioserver.service tvserver.service$//" ${D}${systemd_unitdir}/system/ermgr.service
       sed -i "/^WantedBy=/ s/ui-init.target$/wpeframework.service/" ${D}${systemd_unitdir}/system/ermgr.service
   fi
   # appsservice expects ERM UDS in /tmp folder
   sed -i "/^Environment=\"XDG_RUNTIME_DIR/ s/run\"$/tmp\"/" ${D}${systemd_unitdir}/system/ermgr.service

}

SYSTEMD_SERVICE:${PN} += "ermgr.service"
FILES:${PN} += "${systemd_unitdir}/system/*.service"

