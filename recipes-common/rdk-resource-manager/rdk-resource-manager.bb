LICENSE = "CLOSED"

SRC_URI:append = " file://gen-rmgr.service"
SRC_URI:append = " file://resources.conf"
SRCREV = "${AUTOREV}"
#SRC_URI = "${RDKE_GITHUB_ROOT}/rdk-resource-manager;protocol=${RDKE_GITHUB_PROTOCOL};branch=feature/uds_implement_branch_v3;name=rdkhal"
SRC_URI = "${RDKE_GITHUB_ROOT}/rdk-resource-manager;protocol=${RDKE_GITHUB_PROTOCOL};branch=feature-rdk-adapter;"
 
S = "${WORKDIR}/git"
 
inherit systemd
 
SYSTEMD_AUTO_ENABLE ??= "enable"
DEPENDS = " jsoncpp"
FILES_${PN} += "${libdir}/lib*${SOLIBS}"
 
inherit pkgconfig cmake
EXTRA_OECMAKE += "-DJSONCPP_WITH_CMAKE_PACKAGE=ON"
do_install() {
    install -d ${D}/usr/bin
    install -d ${D}/usr/bin/ResourceManager
    install -d ${D}/usr/bin/ResourceProvider
    install -m 0755 ${B}/ResourceManager/resourcemanager ${D}/usr/bin/ResourceManager
    install -m 0755 ${B}/ResourceProvider/resourceprovider ${D}/usr/bin/ResourceProvider
    install -d ${D}/usr/lib
    install -m 0755 ${B}/DemoClient/libGRManagerClient.so ${D}/usr/lib
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
 
#Copilot
FILES:${PN} += "${libdir}/libGRManagerClient.so*"
FILES:${PN}-dev += "${libdir}/libGRManagerClient.so"
FILES:${PN}-dev = "${includedir}/*.h"
 
# Remove .so files from -dev package
FILES:${PN}-dev:remove = "${libdir}/*.so"
FILES:${PN} += "${systemd_system_unitdir}/gen-rmgr.service"
SYSTEMD_SERVICE:${PN} += "gen-rmgr.service"
 
 
# Final recommended recipe snippet:
FILES:${PN} += "${libdir}/*.so.* ${libdir}/*.so"
FILES:${PN}-dev = "${includedir}/*.h ${libdir}/pkgconfig/*.pc"
