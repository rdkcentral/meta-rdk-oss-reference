SUMMARY = "This receipe compiles the ermgr component"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1d13a8bfca16dbdad01fe5f270451aaa"

S = "${WORKDIR}/git"
SRCREV = "125b87e9dd639d333ea9915fb0b8e463a6adedfa"
SRC_URI = "${CMF_GIT_ROOT}/rdk/components/generic/ermgr;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"
SRC_URI += "file://c0ed8e8.diff"
DEPENDS = "essos "
RDEPENDS:${PN} = " bash "

inherit autotools pkgconfig features_check

acpaths = "-I cfg"

do_install:append() {
   install -d ${D}${systemd_unitdir}/system
   install -m 0644 ${S}/*.h ${D}${includedir}/
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
FILES_${PN}-dev += "${includedir}/*.h"
