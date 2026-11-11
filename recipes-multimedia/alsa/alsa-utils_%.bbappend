EXTRA_OECONF:append = " --with-systemdsystemunitdir=${systemd_system_unitdir} --with-udev-rules-dir=${nonarch_base_libdir}/udev/rules.d"

FILES:${PN}-alsactl:append = " ${systemd_unitdir}/system/* ${systemd_unitdir}/system/sound.target.wants/*"