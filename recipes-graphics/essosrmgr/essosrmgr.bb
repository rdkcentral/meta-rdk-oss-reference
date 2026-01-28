LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=1d13a8bfca16dbdad01fe5f270451aaa \
                    file://LICENSE;md5=1d13a8bfca16dbdad01fe5f270451aaa"

SRC_URI = "${CMF_GIT_ROOT}/rdk/components/generic/ermgr;protocol=${CMF_GIT_PROTOCOL};branch=rdk-next;nobranch=1;name=essosrmgr"
SRC_URI += "file://01-essosResManager.diff"

S = "${WORKDIR}/git"


DEPENDS = "wayland virtual/egl libxkbcommon westeros"

REQUIRED_DISTRO_FEATURES += "wayland"

inherit autotools pkgconfig features_check

PACKAGECONFIG ??= "westeros resmgr"
PACKAGECONFIG[westeros] = "--disable-essoswesterosfree,--enable-essoswesterosfree,westeros-simpleshell virtual/westeros-soc"
PACKAGECONFIG[resmgr] = "--disable-essosresmgrfree,--enable-essosresmgrfree"

# Specify any options you want to pass to the configure script using EXTRA_OECONF:
EXTRA_OECONF = ""

#temporarily added to resolve fullstack build error in vendor builds. Should be removed when ermgr recipe removed from MW build.
RPROVIDES:${PN} = "ermgr"
RREPLACES:${PN} = "ermgr"
RCONFLICTS:${PN} = "ermgr"

acpaths = "-I cfg"

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

