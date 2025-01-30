FILESEXTRAPATHS:append := ":${THISDIR}/${BPN}"
RDEPENDS:${PN} += "bash"
inherit systemd
SRC_URI:append = " file://init.patch \
                   file://cgconfig.conf \
                   file://cgrules.conf \
                   file://cgconfig.service \
                   file://cgrules.service \
                 "
EXTRA_OECONF:append = " --enable-initscript-install"

do_install:append () {
        install -d ${D}${sysconfdir}
        install -m 0755 ${WORKDIR}/cgconfig.conf ${D}${sysconfdir}/
        install -m 0755 ${WORKDIR}/cgrules.conf ${D}${sysconfdir}/
        install -D -m644 ${WORKDIR}/cgconfig.service ${D}${systemd_unitdir}/system/cgconfig.service
        install -D -m644 ${WORKDIR}/cgrules.service ${D}${systemd_unitdir}/system/cgrules.service
}

SYSTEMD_SERVICE:${PN} = "cgconfig.service cgrules.service"

FILES:${PN} += " \
                 ${sysconfdir}/cgconfig.conf \
                 ${sysconfdir}/cgrules.conf \
                 ${systemd_unitdir}/system/cgconfig.service \
                 ${systemd_unitdir}/system/cgrules.service \
               "
# From meta-middleware-development/recipes-oem-element-amlogic/libcgroup/libcgroup_%.bbappend
do_install:append() {
	sed -i 's/basic.target//g' ${D}/${systemd_unitdir}/system/cgconfig.service
	sed -i -e '/After=.*/aDefaultDependencies=no' ${D}${systemd_unitdir}/system/cgconfig.service
	sed -i -e '/Before=/d' ${D}${systemd_unitdir}/system/cgconfig.service
	sed -i 's/basic.target//g' ${D}/${systemd_unitdir}/system/cgrules.service
	sed -i -e '/After=.*/aDefaultDependencies=no' ${D}${systemd_unitdir}/system/cgrules.service
	sed -i -e '/Before=/d' ${D}${systemd_unitdir}/system/cgrules.service
}
