SRC_URI += "file://comcast_9_11_37.dns64.patch \
           "

inherit comcast-package-deploy

BIND_DL="${@bb.utils.contains('DISTRO_FEATURES','dunfell','bind-dl',' ',d)}"
DOWNLOAD_APPS="${@bb.utils.contains('DISTRO_FEATURES','rdm', d.getVar("BIND_DL", True),' ',d)}"
CUSTOM_PKG_EXTNS="dl"
SKIP_MAIN_PKG="yes"

do_install_append () {
    sed -i "/^ExecStartPre=.*/a ExecStartPre=/bin/sh -c '/bin/mkdir -p /run/named; /bin/chmod -R 777 /run/named'" ${D}${systemd_unitdir}/system/named.service
}    

do_install_append_dunfell () {
    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'rdm', 'true', 'false', d)}" = "true" ]
    then
       sed -i "/^After=.*/a After=apps-rdm.service" ${D}${systemd_unitdir}/system/named.service
       sed -i "/^EnvironmentFile=.*/a Environment=\"LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/media/apps/bind-dl/usr/lib/\"" ${D}${systemd_unitdir}/system/named.service
       sed -i "s/^ExecStart=.*/ExecStart=\/media\/apps\/bind-dl\/usr\/sbin\/named \$OPTIONS/g" ${D}${systemd_unitdir}/system/named.service
    fi
}

FILES_${PN}-libs_remove         = "${libdir}/*.so*"
FILES_${PN}-dl_append_dunfell   = "${libdir}/*.so*"
FILES_${PN}-dl_remove_morty     = "${sbindir}/named"
