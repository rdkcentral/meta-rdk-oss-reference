PACKAGECONFIG_remove += " thin-provisioning-tools udev "
DEPENDS_remove = " udev"

EXTRA_OECONF_remove = " \
                --enable-udev_sync \
                --enable-udev_rules \
                --with-udev-prefix= \
"

do_install_prepend_class-native () {

    install -d ${D}${sysconfdir}/lvm

}

BBCLASSEXTEND = "native"
