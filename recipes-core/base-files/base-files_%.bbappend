do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
           echo "export SYSTEMD_PAGER=" >> ${D}${sysconfdir}/profile
    fi
}
