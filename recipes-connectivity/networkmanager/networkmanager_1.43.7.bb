SUMMARY = "NetworkManager"
HOMEPAGE = "https://wiki.gnome.org/Projects/NetworkManager"
SECTION = "net/misc"
LICENSE = "GPL-2.0-or-later & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
                    file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c \
"
DEPENDS = " \
    coreutils-native \
    intltool-native \
    libxslt-native \
    libnl \
    udev \
    util-linux \
    libndp \
    libnewt \
    curl \
    dbus \
"
DEPENDS:append:class-target = " bash-completion"
GNOMEBASEBUILDCLASS = "meson"
inherit gnomebase gettext update-rc.d systemd gobject-introspection gtk-doc update-alternatives upstream-version-is-even
SRC_URI = " \
    ${GNOME_MIRROR}/NetworkManager/${@gnome_verdir("${PV}")}/NetworkManager-${PV}.tar.xz \
    file://${BPN}.initd \
    file://95-logging.conf \
    file://NetworkManager.conf \
    file://NM-wpa-service.patch \
    file://NM_Dispatcher.patch \
"

SRC_URI[sha256sum] = "eb4dd6311f4dbf8b080439a65a3dd0db4fddbd3ebd1ea45994c31a497bf75885"

#VOLATILE_BINDS:append = "/var/run/NetworkManager/ /etc/NetworkManager/\n"

S = "${WORKDIR}/NetworkManager-${PV}"
# ['auto', 'symlink', 'file', 'netconfig', 'resolvconf']
NETWORKMANAGER_DNS_RC_MANAGER_DEFAULT ??= "auto"
# ['dhcpcanon', 'dhclient', 'dhcpcd', 'internal', 'nettools']
NETWORKMANAGER_DHCP_DEFAULT ??= "internal"
# The default gets detected based on whether /usr/sbin/nft or /usr/sbin/iptables is installed, with nftables preferred.
# ['', 'iptables', 'nftables']
NETWORKMANAGER_FIREWALL_DEFAULT ??= "iptables"
EXTRA_OEMESON = "\
    -Difcfg_rh=false \
    -Dtests=yes \
    -Dnmtui=false \
    -Dudev_dir=${nonarch_base_libdir}/udev \
    -Dlibpsl=false \
    -Dqt=false \
    -Dconfig_dns_rc_manager_default=${NETWORKMANAGER_DNS_RC_MANAGER_DEFAULT} \
    -Dconfig_dhcp_default=${NETWORKMANAGER_DHCP_DEFAULT} \
    -Ddhcpcanon=false \
    -Diptables=${sbindir}/iptables \
    -Dnft=${sbindir}/nft \
"
# stolen from https://github.com/void-linux/void-packages/blob/master/srcpkgs/NetworkManager/template
# avoids:
# | ../NetworkManager-1.16.0/libnm-core/nm-json.c:106:50: error: 'RTLD_DEEPBIND' undeclared (first use in this function); did you mean 'RTLD_DEFAULT'?
CFLAGS:append:libc-musl = " \
    -DRTLD_DEEPBIND=0 \
"
do_compile:prepend() {
    export GI_TYPELIB_PATH="${B}}/src/libnm-client-impl${GI_TYPELIB_PATH:+:$GI_TYPELIB_PATH}"
}
PACKAGECONFIG ??= "nss ifupdown dnsmasq vala \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', bb.utils.contains('DISTRO_FEATURES', 'x11', 'consolekit', '', d), d)} \
    ${@bb.utils.filter('DISTRO_FEATURES', 'wifi polkit', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux audit', '', d)} \
"

#inherit ${@bb.utils.contains('PACKAGECONFIG', 'vala', 'vala', '', d)}
PACKAGECONFIG[systemd] = "\
    -Dsystemdsystemunitdir=${systemd_unitdir}/system -Dsession_tracking=systemd,\
    -Dsystemdsystemunitdir=no -Dsystemd_journal=false -Dsession_tracking=no\
"
PACKAGECONFIG[polkit] = "-Dpolkit=true,-Dpolkit=false,polkit"
# consolekit is not picked by shlibs, so add it to RDEPENDS too
#PACKAGECONFIG[consolekit] = "-Dsession_tracking_consolekit=true,-Dsession_tracking_consolekit=false,consolekit,consolekit"
PACKAGECONFIG[modemmanager] = "-Dmodem_manager=true,-Dmodem_manager=false,modemmanager mobile-broadband-provider-info"
PACKAGECONFIG[ppp] = "-Dppp=false -Dpppd=${sbindir}/pppd,-Dppp=false,ppp"
PACKAGECONFIG[dnsmasq] = "-Ddnsmasq=${bindir}/dnsmasq"
PACKAGECONFIG[nss] = "-Dcrypto=nss,,nss"
#PACKAGECONFIG[resolvconf] = "-Dresolvconf=${base_sbindir}/resolvconf,-Dresolvconf=no,,resolvconf"
PACKAGECONFIG[gnutls] = "-Dcrypto=gnutls,,gnutls"
PACKAGECONFIG[crypto-null] = "-Dcrypto=null"
PACKAGECONFIG[wifi] = "-Dwext=true -Dwifi=true,-Dwext=false -Dwifi=false"
#PACKAGECONFIG:append = "iwd"
#PACKAGECONFIG[iwd] = "-Diwd=true ,-Diwd=false"
PACKAGECONFIG[ifupdown] = "-Difupdown=true,-Difupdown=false"
#PACKAGECONFIG[cloud-setup] = "-Dnm_cloud_setup=true,-Dnm_cloud_setup=false"
PACKAGECONFIG[ovs] = "-Dovs=true,-Dovs=false,jansson"
PACKAGECONFIG[audit] = "-Dlibaudit=yes,-Dlibaudit=no"
PACKAGECONFIG[selinux] = "-Dselinux=true,-Dselinux=false,libselinux"
#PACKAGECONFIG[vala] = "-Dvapi=true,-Dvapi=false"
#PACKAGECONFIG[dhcpcd] = "-Ddhcpcd=${base_sbindir}/dhcpcd,-Ddhcpcd=no,,dhcpcd"
#PACKAGECONFIG[dhclient] = "-Ddhclient=yes,-Ddhclient=no,,dhcp"
PACKAGECONFIG[concheck] = "-Dconcheck=true,-Dconcheck=false"
# The following PACKAGECONFIG is used to determine whether NM is managing /etc/resolv.conf itself or not
#PACKAGECONFIG[man-resolv-conf] = ",,"
#PACKAGECONFIG:append = "man-resolv-conf"
PACKAGES =+ " \
    libnm \
    ${PN}-wifi \
    ${PN}-daemon \
    ${PN}-man-resolv-conf \
"
SYSTEMD_PACKAGES = "${PN}-daemon "
INITSCRIPT_PACKAGES = "${PN}-daemon"
NETWORKMANAGER_PLUGINDIR = "${libdir}/NetworkManager/${PV}"
NETWORKMANAGER_DISPATCHERDIR = "${nonarch_libdir}/NetworkManager/dispatcher.d"
SUMMARY:libnm = "Libraries for adding NetworkManager support to applications"
#FILES:libnm = "\
#    ${libdir}/libnm.so.* \
#    ${libdir}/girepository-1.0/NM-1.0.typelib \
#"
SUMMARY:${PN}-adsl = "ADSL device plugin for NetworkManager"
#FILES:${PN}-adsl = "${NETWORKMANAGER_PLUGINDIR}/libnm-device-plugin-adsl.so"
#RDEPENDS:${PN}-adsl += "${PN}-daemon"
SUMMARY:${PN}-bluetooth = "Bluetooth device plugin for NetworkManager"
#FILES:${PN}-bluetooth = "${NETWORKMANAGER_PLUGINDIR}/libnm-device-plugin-bluetooth.so"
#SUMMARY:${PN}-cloud-setup = "Automatically configure NetworkManager in cloud"
#FILES:${PN}-cloud-setup = " \
#    ${libexecdir}/nm-cloud-setup \
#    ${systemd_system_unitdir}/nm-cloud-setup.service \
#    ${systemd_system_unitdir}/nm-cloud-setup.timer \
#    ${libdir}/NetworkManager/dispatcher.d/90-nm-cloud-setup.sh \
#    ${libdir}/NetworkManager/dispatcher.d/no-wait.d/90-nm-cloud-setup.sh \
#"
#RDEPENDS:${PN}-cloud-setup += "${PN}-daemon"
#ALLOW_EMPTY:${PN}-cloud-setup = "1"
#SYSTEMD_SERVICE:${PN}-cloud-setup = "${@bb.utils.contains('PACKAGECONFIG', 'cloud-setup', 'nm-cloud-setup.service nm-cloud-setup.timer', '', d)}"

#SUMMARY:${PN}-nmtui = "NetworkManager curses-based UI"
#FILES:${PN}-nmtui = " \
#    ${bindir}/nmtui \
#    ${bindir}/nmtui-edit \
#    ${bindir}/nmtui-connect \
#    ${bindir}/nmtui-hostname \
#"
#RDEPENDS:${PN}-nmtui += "${PN}-daemon"
SUMMARY:${PN}-wifi = "Wifi plugin for NetworkManager"
#FILES:${PN}-wifi = "\
#    ${NETWORKMANAGER_PLUGINDIR}/libnm-device-plugin-wifi.so \
#    ${libdir}/NetworkManager/conf.d/enable-iwd.conf \
#"
def get_wifi_deps(d):
    packageconfig = (d.getVar('PACKAGECONFIG') or "").split()
    if 'wifi' in packageconfig:
        if 'iwd' in packageconfig:
            return 'iwd'
        else:
            return 'wpa-supplicant'
    else:
        return ''
RDEPENDS:${PN}-wifi += "${PN}-daemon ${@get_wifi_deps(d)}"
SUMMARY:${PN}-wwan = "Mobile broadband device plugin for NetworkManager"
#FILES:${PN}-wwan = "\
#    ${NETWORKMANAGER_PLUGINDIR}/libnm-device-plugin-wwan.so \
#    ${NETWORKMANAGER_PLUGINDIR}/libnm-wwan.so \
#"
RDEPENDS:${PN}-wwan += "${PN}-daemon ${@bb.utils.contains('PACKAGECONFIG','modemmanager','modemmanager','',d)}"
SUMMARY:${PN}-ovs = "Open vSwitch device plugin for NetworkManager"
#FILES:${PN}-ovs = "\
#    ${NETWORKMANAGER_PLUGINDIR}/libnm-device-plugin-ovs.so \
#    ${systemd_system_unitdir}/NetworkManager.service.d/NetworkManager-ovs.conf \
#"
RDEPENDS:${PN}-ovs += "${PN}-daemon"
#SUMMARY:${PN}-ppp = "PPP plugin for NetworkManager"
#FILES:${PN}-ppp = "\
#    ${NETWORKMANAGER_PLUGINDIR}/libnm-ppp-plugin.so \
#    ${libdir}/pppd/*/nm-pppd-plugin.so \
#"
#RDEPENDS:${PN}-ppp += "${PN}-daemon ${@bb.utils.contains('PACKAGECONFIG','ppp','ppp','',d)}"
FILES:${PN}-dev += " \
    ${libdir}/NetworkManager/*.la \
    ${NETWORKMANAGER_PLUGINDIR}/*.la \
    ${datadir}/dbus-1/interfaces/*.xml \
"
SUMMARY:${PN}-daemon += "The NetworkManager daemon"
FILES:${PN}-daemon += " \
    ${datadir}/polkit-1 \
    ${datadir}/dbus-1 \
    ${libdir}/NetworkManager \
    ${libexecdir} \
    ${localstatedir}/lib/NetworkManager \
    ${NETWORKMANAGER_DISPATCHERDIR} \
    ${nonarch_base_libdir}/udev/* \
    ${nonarch_libdir}/firewalld \
    ${nonarch_libdir}/NetworkManager/conf.d \
    ${nonarch_libdir}/NetworkManager/dispatcher.d/no-wait.d \
    ${nonarch_libdir}/NetworkManager/dispatcher.d/pre-down.d \
    ${nonarch_libdir}/NetworkManager/dispatcher.d/pre-up.d \
    ${nonarch_libdir}/NetworkManager/VPN \
    ${nonarch_libdir}/NetworkManager/system-connections \
    ${sbindir}/NetworkManager \
    ${sysconfdir}/init.d/network-manager \
    ${sysconfdir}/NetworkManager \
    ${sysconfdir}/sysconfig/network-scripts \
    ${systemd_system_unitdir} \
"
FILES:${PN}:remove = "${sysconfdir}/resolv.dnsmasq"
FILES:${PN}:remove = "${sysconfdir}/resolv.conf"
FILES:${PN}-daemon:remove = "${sysconfdir}/resolv.conf"
FILES:${PN}-daemon:remove = "${sysconfdir}/resolv.dnsmasq"
FILES:${PN}-daemon:remove = "${systemd_system_unitdir}/NetworkManager-wait-online.service"
#{nonarch_libdir}/NetworkManager/system-connections
RDEPENDS:${PN}-daemon += "\
    ${@bb.utils.contains('PACKAGECONFIG', 'ifupdown', 'bash', '', d)} \
"
RRECOMMENDS:${PN}-daemon += "\
    ${NETWORKMANAGER_FIREWALL_DEFAULT} \
    ${@bb.utils.filter('PACKAGECONFIG', 'dnsmasq', d)} \
"
INITSCRIPT_NAME:${PN}-daemon = "network-manager"
SYSTEMD_SERVICE:${PN}-daemon = "\
    NetworkManager.service \
    NetworkManager-dispatcher.service \
"
SYSTEMD_SERVICE:${PN}-daemon:remove = "NetworkManager-wait-online.service"
RCONFLICTS:${PN}-daemon += "connman"
ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE:${PN}-daemon = "${@bb.utils.contains('PACKAGECONFIG','man-resolv-conf','resolv-conf','',d)}"
ALTERNATIVE_TARGET[resolv-conf] = "${@bb.utils.contains('PACKAGECONFIG','man-resolv-conf','${sysconfdir}/resolv-conf.NetworkManager','',d)}"
ALTERNATIVE_LINK_NAME[resolv-conf] = "${@bb.utils.contains('PACKAGECONFIG','man-resolv-conf','${sysconfdir}/resolv.conf','',d)}"
# The networkmanager package is an empty meta package which weakly depends on all the compiled features.
# Install this package to get all plugins and related dependencies installed. Alternatively just install
# plugins and related dependencies e.g. by installing networkmanager-wifi or networkmanager-wwan
# packages to the firmware.
ALLOW_EMPTY:${PN} = "1"
RRECOMMENDS:${PN} += "\
    ${@bb.utils.contains('PACKAGECONFIG','wifi','${PN}-wifi','',d)} \
"
do_install:append() {
    install -d ${D}${sysconfdir}
    install -d ${D}${sysconfdir}/NetworkManager/
    install -d ${D}${sysconfdir}/NetworkManager/conf.d/
    install ${WORKDIR}/NetworkManager.conf ${D}${sysconfdir}/NetworkManager/NetworkManager.conf
    install ${WORKDIR}/95-logging.conf ${D}${sysconfdir}/NetworkManager/conf.d/95-logging.conf

    install -Dm 0755 ${WORKDIR}/${BPN}.initd ${D}${sysconfdir}/init.d/network-manager

    rm -rf ${D}/run ${D}${localstatedir}/run
    if ${@bb.utils.contains('PACKAGECONFIG','man-resolv-conf','true','false',d)}; then
        # For read-only filesystem, do not create links during bootup
        # ln -sf ../run/NetworkManager/resolv.conf ${D}${sysconfdir}/resolv-conf.NetworkManager
        ln -sf /opt/NetworkManager/system-connections ${D}${sysconfdir}/NetworkManager/
        # systemd v210 and newer do not need this rule fil
        rm ${D}/${nonarch_base_libdir}/udev/rules.d/84-nm-drivers.rules
    fi
    
    ln -sf /opt/NetworkManager/system-connections ${D}${sysconfdir}/NetworkManager/
    rm -f ${D}${systemd_system_unitdir}/NetworkManager-wait-online.service
    # Enable iwd if compiled
    if ${@bb.utils.contains('PACKAGECONFIG','iwd','true','false',d)}; then
        install -Dm 0644 ${UNPACKDIR}/enable-iwd.conf ${D}${nonarch_libdir}/NetworkManager/conf.d/enable-iwd.conf
    fi

    # Enable dhcpd if compiled
    if ${@bb.utils.contains('PACKAGECONFIG','dhcpcd','true','false',d)}; then
        install -Dm 0644 ${UNPACKDIR}/enable-dhcpcd.conf ${D}${nonarch_libdir}/NetworkManager/conf.d/enable-dhcpcd.conf
    fi
}

inherit syslog-ng-config-gen
SYSLOG-NG_FILTER = "networkmanager"
SYSLOG-NG_SERVICE_networkmanager = "NetworkManager.service"
SYSLOG-NG_DESTINATION_networkmanager = "NetworkManager.log"
SYSLOG-NG_LOGRATE_networkmanager = "high"
