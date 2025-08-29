FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

CFLAGS += " -DNO_INOTIFY"

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

do_install:append() {
     sed -i -- 's/#resolv-file=/resolv-file="\/etc\/resolv.dnsmasq"/g' ${D}/etc/dnsmasq.conf
     sed -i -- 's/#user=/user=root/g' ${D}/etc/dnsmasq.conf
     sed -i -- 's/#dhcp-leasefile=\/var\/lib\/misc\/dnsmasq.leases/dhcp-leasefile=\/tmp\/dnsmasq.leases/g' ${D}/etc/dnsmasq.conf
     rm ${D}${systemd_unitdir}/system/dnsmasq.service
}

RDEPENDS:${PN} += "busybox"
