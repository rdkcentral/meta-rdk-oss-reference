do_install:append:client() {
     rm -f ${D}{systemd_unitdir}/ntp-units.d/60-ntpd.list
     rm -f ${D}{systemd_unitdir}/ntp-units.d/
     rm -f ${D}${systemd_unitdir}/system/ntpd.service 
}

do_install:append:hybrid() {
     rm -f ${D}{systemd_unitdir}/ntp-units.d/60-ntpd.list
     rm -f ${D}{systemd_unitdir}/ntp-units.d/
     rm -f ${D}${systemd_unitdir}/system/ntpd.service 
}

SYSTEMD_SERVICE:${PN}:remove:client = "ntpd.service"
SYSTEMD_SERVICE:${PN}:remove:hybrid = "ntpd.service"

# Broadband Devices
inherit breakpad-logmapper logrotate_config

ISSYSTEMD = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}"

LOGROTATE_NAME = "ntp"
LOGROTATE_LOGNAME_ntp="ntp.log"
LOGROTATE_SIZE_MEM_ntp="409600"
LOGROTATE_ROTATION_MEM_ntp="2"
LOGROTATE_SIZE_ntp="1572864"
LOGROTATE_ROTATION_ntp="3"

do_install:append:broadband() {

     rm -f ${D}{systemd_unitdir}/ntp-units.d/60-ntpd.list
     rm -f ${D}{systemd_unitdir}/ntp-units.d/

     if [ ${ISSYSTEMD} = "true" ]; then	 
	 # NTP Was Architected to Utopia WAN Sys Events
	 sed -i -e 's#After=network.target#After=network-online.target CcspPandMSsp.service#' ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i '/Type=forking/a Environment="NTP_CONF_TMP=/tmp/ntp.conf"' ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i -e 's#ExecStart=/usr/sbin/ntpd -u ntp:ntp -p /run/ntpd.pid -g#ExecStart=/usr/sbin/ntpd -u ntp:ntp -p /run/ntpd.pid -l /rdklogs/logs/ntpLog.log -c $NTP_CONF_TMP  -g#' ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i '/ExecStart=\/usr\/sbin\/ntpd \-u ntp:ntp \-p \/run\/ntpd.pid \-l \/rdklogs\/logs\/ntpLog.log \-c \$NTP_CONF_TMP  \-g/a Restart=always' ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i '/Restart=always/a StandardOutput=syslog+console' ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i '/\[Install\]/d'  ${D}${systemd_unitdir}/system/ntpd.service
	 sed -i '/WantedBy=multi-user.target/d'  ${D}${systemd_unitdir}/system/ntpd.service
	 #sed -i '/Restart=always/a ExecStartPost=\/bin\/touch \/tmp\/clock-event' ${D}${systemd_unitdir}/system/ntpd.service
	 else
     rm -f ${D}${systemd_unitdir}/system/ntpd.service 
	 fi
}
# Breakpad processname and logfile mapping
BREAKPAD_LOGMAPPER_PROCLIST = "ntpd"
BREAKPAD_LOGMAPPER_LOGLIST = "ntpLog.log"
