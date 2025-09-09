FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://dnsmasq.service"

SRC_URI += "file://dns.conf"
     
SRC_URI += "file://dnsmasqLauncher.sh"
SRC_URI:append:broadband += "file://dnsmasq_syslog_quiet.patch"

inherit syslog-ng-config-gen logrotate_config
SYSLOG-NG_FILTER = "dnsmasq"
SYSLOG-NG_SERVICE_dnsmasq = "dnsmasq.service"
SYSLOG-NG_DESTINATION_dnsmasq = "dnsmasq.log"
SYSLOG-NG_LOGRATE_dnsmasq = "low"

LOGROTATE_NAME="dnsmasq"
LOGROTATE_LOGNAME_dnsmasq="dnsmasq.log"
#HDD_ENABLE
LOGROTATE_SIZE_dnsmasq="1572864"
LOGROTATE_ROTATION_dnsmasq="3"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_dnsmasq="1572864"
LOGROTATE_ROTATION_MEM_dnsmasq="3"

PACKAGECONFIG:append = " dbus"
PACKAGECONFIG[dbus] = "--enable-dbus,--disable-dbus,dbus"
# dnsmasq-service package will contain dnsmasq.service and dnsmasqLauncher.sh
# By default, NetworkManager will start and manage dnsmasq. 
# If you wish to use dnsmasq as a standlaone service through this package, make sure to disable dnsmasq configuration in NetworkManager.
PACKAGES =+ "${PN}-service"

do_install:append() {
     install -d ${D}${base_libdir}/rdk
     install -m 0644 ${WORKDIR}/dnsmasq.service ${D}${systemd_unitdir}/system
     sed -i -- 's/#resolv-file=/resolv-file="\/etc\/resolv.dnsmasq"/g' ${D}/etc/dnsmasq.conf
     sed -i -- 's/#user=/user=root/g' ${D}/etc/dnsmasq.conf
     sed -i -- 's/#dhcp-leasefile=\/var\/lib\/misc\/dnsmasq.leases/dhcp-leasefile=\/tmp\/dnsmasq.leases/g' ${D}/etc/dnsmasq.conf
     install -m 0755 ${S}/../dnsmasqLauncher.sh ${D}${base_libdir}/rdk
     install -D -m 0644 ${WORKDIR}/dns.conf ${D}${systemd_unitdir}/system/dnsmasq.service.d/dns.conf
}

RDEPENDS:${PN} += "busybox"

FILES:${PN}-service = "${systemd_unitdir}/system/* \
                       ${base_libdir}/rdk/* \
                      "
SYSTEMD_SERVICE:${PN}-service  = "dnsmasq.service"
SYSTEMD_SERVICE:${PN}:remove  = "dnsmasq.service"
SYSTEMD_AUTO_ENABLE = "disable"
