do_install_append_dunfell () {

sed -i -e "/Type=oneshot/a\\
ExecStartPre=/sbin/mount-copybind /tmp/postinsts /etc/systemd/system/sysinit.target.wants/" ${D}${systemd_unitdir}/system/run-postinsts.service

}
