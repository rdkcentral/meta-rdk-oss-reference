FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
        file://client_back.conf \
        "

RDEPENDS_${PN}-client_append_broadband = " bash"
RDEPENDS_${PN}-client_remove_broadband_morty = "bash"

SRC_URI_append_hybrid = " file://client_back_hybrid.conf"

SRC_URI_append_client = " file://client_back_client.conf \
                          file://0001-BLDK-794-Client-notify-linux.patch \
                        "

SRC_URI_append_broadband = " file://client-notify.patch \
                             file://dibbler-init.sh \
                             file://prepare_dhcpv6_config.sh \
                             file://udhcpc.vendor_specific \
                             file://dibbler-server-init.sh \
                             file://server-notify.sh \
                             file://dibbler_clear_sysevent_for_null_option23.patch \
                             file://fix_type_casting.patch \
                             ${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable','file://oss_dibbler_conf.sh','',d)} \
"

SRC_URI_append_broadband = " ${@bb.utils.contains('DISTRO_FEATURES', 'nat46','file://client-notify-option95.patch','', d)}"

inherit logrotate_config

LOGROTATE_NAME = "dibbler"
LOGROTATE_LOGNAME_dibbler = "dibbler.log"
LOGROTATE_SIZE_dibbler = "1572864"
LOGROTATE_ROTATION_dibbler = "3"
LOGROTATE_SIZE_MEM_dibbler = "1572864"
LOGROTATE_ROTATION_MEM_dibbler = "3"

do_install_append() {
        install -d ${D}${sysconfdir}/dibbler
        install -m 0644 ${WORKDIR}/client_back.conf ${D}${sysconfdir}/dibbler/
}

do_install_append_hybrid() {
        install -d ${D}${sysconfdir}/dibbler
        install -m 0644 ${WORKDIR}/client_back_hybrid.conf ${D}${sysconfdir}/dibbler/client_back.conf
}

do_install_append_client() {
        install -d ${D}${sysconfdir}/dibbler
        install -d ${D}${base_libdir}/rdk
        install -m 0644 ${WORKDIR}/client_back_client.conf ${D}${sysconfdir}/dibbler/client_back.conf
        install -m 755 ${S}/scripts/notify-scripts/client-notify-linux.sh ${D}${base_libdir}/rdk/client-notify.sh
}

do_install_append_broadband() {
    install -d ${D}${base_libdir}/rdk

    install -m 755 ${S}/scripts/notify-scripts/client-notify-bsd.sh ${D}${base_libdir}/rdk/client-notify.sh
    install -m 755 ${WORKDIR}/dibbler-init.sh ${D}${base_libdir}/rdk/dibbler-init.sh
    if ${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', 'true', 'false', d)}; then
        install -m 755 ${WORKDIR}/oss_dibbler_conf.sh ${D}${base_libdir}/rdk/prepare_dhcpv6_config.sh
    else
        install -m 755 ${WORKDIR}/prepare_dhcpv6_config.sh ${D}${base_libdir}/rdk/prepare_dhcpv6_config.sh
    fi

    install -m 755 ${WORKDIR}/udhcpc.vendor_specific ${D}${sysconfdir}/udhcpc.vendor_specific

    if ${@bb.utils.contains('DISTRO_FEATURES', 'bci', 'true', 'false', d)}; then
        install -m 755 ${WORKDIR}/dibbler-server-init.sh ${D}${base_libdir}/rdk/dibbler-server-init.sh
        install -m 755 ${WORKDIR}/server-notify.sh ${D}${base_libdir}/rdk/server-notify.sh
    fi
}

FILES_${PN}-client += "${sysconfdir}/dibbler/* \
                       ${base_libdir}/rdk/*    \
                      "
FILES_${PN}_append_broadband += " ${sysconfdir}/*"
FILES_${PN}-client_append_broadband += " ${base_libdir}/rdk/*"

ALLOW_EMPTY_${PN} = "1"
