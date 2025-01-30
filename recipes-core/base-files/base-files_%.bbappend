do_install_append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
           echo "export SYSTEMD_PAGER=/bin/cat" >> ${D}${sysconfdir}/profile
    fi
}
