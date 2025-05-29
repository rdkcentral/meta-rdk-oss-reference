DESCRIPTION = "Resource Manager for RDK"

LICENSE = "CLOSED"

FILESEXTRAPATHS:append := ":${THISDIR}/files:"
SRC_URI = " \
  git://git@github.com/rdk-e/rdk-resource-manager.git;protocol=ssh;branch=feature/change_resource_id_name_apr28 \
"
SRC_URI += " file://gen-rmgr.service"
SRC_URI += " file://resources.conf"

SRCREV = "485a6281a90063ad43e74ad9efeb9c6173d6468e"

S = "${WORKDIR}/git"

inherit systemd

SYSTEMD_AUTO_ENABLE ??= "enable"
DEPENDS += " jsoncpp"

inherit pkgconfig cmake
EXTRA_OECMAKE += "-DJSONCPP_WITH_CMAKE_PACKAGE=ON"
do_install() {
    install -d ${D}/usr/bin
    install -d ${D}/usr/bin/ResourceManager
    install -d ${D}/usr/bin/ResourceProvider
    install -m 0755 ${B}/ResourceManager/resourcemanager ${D}/usr/bin/ResourceManager
    install -m 0755 ${B}/ResourceProvider/resourceprovider ${D}/usr/bin/ResourceProvider
    install -d ${D}${libdir}
    install -m 0755 ${B}/DemoClient/libGRManagerClient.so ${D}${libdir}/libGRManagerClient.so
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/gen-rmgr.service ${D}${systemd_unitdir}/system
    install -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/resources.conf ${D}${sysconfdir}/default
    install -d ${D}/usr/include
    install -m 0755 ${S}/DemoClient/ClientWrapper.h ${D}/usr/include
    install -d ${D}/etc/profile.d
    echo 'export CONFIG_FILE_PATH=${sysconfdir}/default/resources.conf' > ${D}/etc/profile.d/configfile.sh
    chmod 0755 ${D}/etc/profile.d/configfile.sh
}



FILES:${PN} += "${libdir}/ResourceManager/resourcemanager"
FILES:${PN} += "${libdir}/ResourceProvider/resourceprovider"
FILES:${PN} += " ${sysconfdir}/default/resources.conf"
SYSTEMD_SERVICE:${PN} += "gen-rmgr.service"
FILES:${PN} += "${systemd_unitdir}/system/*.service"
FILES:${PN} += "${libdir}/*.so*"
FILES_SOLIBSDEV = ""
INSANE_SKIP:${PN} += "dev-so"
