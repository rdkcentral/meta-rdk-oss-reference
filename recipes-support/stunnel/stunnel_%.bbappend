FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

do_install_append() {

        rm -rf ${D}${sysconfdir}/stunnel
}


#From meta-rdk-comcast/recipes-support/stunnel/stunnel_%.bbappend

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI += '${@bb.utils.contains("DISTRO_FEATURES", "morty", "file://separate_keying_for_dev_prod_vm_stunnel_morty.patch", "file://separate_keying_for_dev_prod_vm_stunnel.patch", d)}'

#From meta-rdk-comcast-video/recipes-support/stunnel/stunnel_%.bbappend

do_install_append_client(){
    rm -f ${D}${systemd_unitdir}/system/stunnel.service
    rm -rf ${D}${bindir}/stunnel3
}

inherit logrotate_config

LOGROTATE_NAME="stunnel"
LOGROTATE_LOGNAME_stunnel="stunnel.log"
#HDD_ENABLE
LOGROTATE_SIZE_stunnel="1572864"
LOGROTATE_ROTATION_stunnel="3"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_stunnel="1572864"
LOGROTATE_ROTATION_MEM_stunnel="3"

FILES_${PN}_remove_client = "${systemd_unitdir}/system/*"
SYSTEMD_SERVICE_${PN}_remove_client = "stunnel.service"

RDEPENDS_${PN}_remove = "perl"
