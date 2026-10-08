do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
           echo "export SYSTEMD_PAGER=/bin/cat" >> ${D}${sysconfdir}/profile
           #SYSTEMD_PAGER will be ignored if SYSTEMD_PAGERSECURE is not set. cat doesn't have any secure mode. Only less have secure mode as of now. Since we are using cat as our pager, disabling the pagersecure.
           echo "export SYSTEMD_PAGERSECURE=0" >> ${D}${sysconfdir}/profile
    fi
}
