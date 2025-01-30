do_install:append(){
    if ${@bb.utils.contains('DISTRO_FEATURES', 'rdm', 'true', 'false', d)}; then
        sed -i '/touch "\/tmp\/\.automount/ a \\t\tsh /usr/bin/rdm -u /run/media/$name' ${D}/etc/udev/scripts/mount.sh
    fi

    if ${@bb.utils.contains('DISTRO_FEATURES', 'usbaccess', 'true', 'false', d)}; then
        sed -i '/touch "\/tmp\/\.automount/ a \\t\tsh /lib/rdk/UsbAccess.sh /run/media/$name' ${D}/etc/udev/scripts/mount.sh
    fi
}
