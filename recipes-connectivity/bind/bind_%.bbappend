FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


EXTRA_OECONF_append_mips = " --disable-atomic"

EXTRA_OECONF_append_dunfell = " --disable-threads"

RDEPENDS_${PN}_remove = "python3-core"

PACKAGE_BEFORE_PN += "${PN}-dl ${PN}-named"

SRC_URI_append = " \
                  file://named.conf.options \
                  file://named_start_post_rdm.sh \
                 "
SRC_URI_append_dunfell = " file://build-error-disable-threads.patch"

do_install_append () {
    install -d ${D}${sysconfdir}/bind
    install -d ${D}/var/cache/bind
    install -d ${D}/etc/rdm/post-services
    
    install ${WORKDIR}/named.conf.options ${D}${sysconfdir}/bind/
    sed -i "/.*include.*rndc.*/d" ${D}${sysconfdir}/bind/named.conf
    sed -i 's#.*rndc.*#;#g'  ${D}${sysconfdir}/bind/named.conf
    install -m 755 ${WORKDIR}/named_start_post_rdm.sh ${D}/etc/rdm/post-services
}

inherit syslog-ng-config-gen logrotate_config
SYSLOG-NG_FILTER = "named"
SYSLOG-NG_SERVICE_named = "named.service"
SYSLOG-NG_DESTINATION_named = "named.log"
SYSLOG-NG_LOGRATE_named = "low"

LOGROTATE_NAME="named"
LOGROTATE_LOGNAME_named="named.log"
#HDD_ENABLE
LOGROTATE_SIZE_named="128000"
LOGROTATE_ROTATION_named="3"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_named="128000"
LOGROTATE_ROTATION_MEM_named="3"

FILES_${PN}-named = "${systemd_unitdir}/system/named.service \
                     ${sysconfdir}/default/bind9 \
                     ${sysconfdir}/bind/named.conf \
                     ${sysconfdir}/bind/named.conf.local \
                     ${sysconfdir}/bind/named.conf.options \
                     ${sysconfdir}/bind/db.0 \
                     ${sysconfdir}/bind/db.127 \
                     ${sysconfdir}/bind/db.empty \
                     ${sysconfdir}/bind/db.local \
                     ${sysconfdir}/bind/db.root \
                     ${localstatedir}/cache/bind \
                     ${sysconfdir}/syslog-ng/* \
                    "
FILES_${PN}-dl = "${sbindir}/named \
                  ${sysconfdir}/rdm/post-services/named_start_post_rdm.sh \
                 "
SYSTEMD_SERVICE_${PN}_remove = "named.service"
SYSTEMD_SERVICE_${PN}-named_append = " named.service "

USERADD_PACKAGES = "${PN}-named"
USERADD_PARAM_${PN}-named = "--system --home ${localstatedir}/cache/bind --no-create-home \
                       --user-group bind"

