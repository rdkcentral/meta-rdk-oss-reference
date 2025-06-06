FILESEXTRAPATHS:prepend := "${THISDIR}/files:"


EXTRA_OECONF:append:mips = " --disable-atomic"

EXTRA_OECONF:append:dunfell = " --disable-threads"

RDEPENDS:${PN}:remove = "python3-core"

PACKAGE_BEFORE_PN += "${PN}-dl ${PN}-named"

SRC_URI:append = " \
                  file://named.conf.options \
                  file://named_start_post_rdm.sh \
                 "

do_install:append () {
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

FILES:${PN}-named = "${systemd_unitdir}/system/named.service \
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
FILES:${PN}-dl = "${sbindir}/named \
                  ${sysconfdir}/rdm/post-services/named_start_post_rdm.sh \
                 "
SYSTEMD_SERVICE:${PN}:remove = "named.service"
SYSTEMD_SERVICE:${PN}-named:append = " named.service "

USERADD_PACKAGES = "${PN}-named"
USERADD_PARAM:${PN}-named = "--system --home ${localstatedir}/cache/bind --no-create-home \
                       --user-group bind"

SRC_URI += "file://comcast_9_18_5.dns64.patch \
            file://read-only-sessionkey-kirkstone.patch \
           "
EXTRA_OECONF:append = " --without-readline"

inherit comcast-package-deploy

BIND_DL="bind-dl"
DOWNLOAD_APPS="${@bb.utils.contains('DISTRO_FEATURES','rdm', d.getVar("BIND_DL", True),' ',d)}"
CUSTOM_PKG_EXTNS="dl"
SKIP_MAIN_PKG="yes"

do_install:append () {
    sed -i "/^ExecStartPre=.*/a ExecStartPre=/bin/sh -c '/bin/mkdir -p /run/named; /bin/chmod -R 777 /run/named'" ${D}${systemd_unitdir}/system/named.service
    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'rdm', 'true', 'false', d)}" = "true" ]
    then
       sed -i "/^After=.*/a After=apps-rdm.service" ${D}${systemd_unitdir}/system/named.service
       sed -i "/^EnvironmentFile=.*/a Environment=\"LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/media/apps/bind-dl/usr/lib/\"" ${D}${systemd_unitdir}/system/named.service
       sed -i "s/^ExecStart=.*/ExecStart=\/media\/apps\/bind-dl\/usr\/sbin\/named \$OPTIONS/g" ${D}${systemd_unitdir}/system/named.service
    fi
}

FILES:${PN}-libs:remove         = "/usr/lib/named/*.so* /usr/lib/*-9.18.5.so"
FILES:${PN}-dl:append           = "${libdir}/*.so*"
