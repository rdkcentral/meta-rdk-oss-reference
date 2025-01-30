FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

do_install:append() {

        rm -rf ${D}${sysconfdir}/stunnel
}


#From meta-rdk-comcast/recipes-support/stunnel/stunnel_%.bbappend

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://separate_keying_for_dev_prod_vm_stunnel.patch"

inherit logrotate_config

LOGROTATE_NAME="stunnel"
LOGROTATE_LOGNAME_stunnel="stunnel.log"
#HDD_ENABLE
LOGROTATE_SIZE_stunnel="1572864"
LOGROTATE_ROTATION_stunnel="3"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_stunnel="1572864"
LOGROTATE_ROTATION_MEM_stunnel="3"

#From meta-rdk-comcast-video/recipes-support/stunnel/stunnel_%.bbappend

do_install:append:client(){
    rm -f ${D}${systemd_unitdir}/system/stunnel.service
    rm -rf ${D}${bindir}/stunnel3
}


FILES:${PN}:remove:client = "${systemd_unitdir}/system/*"
SYSTEMD_SERVICE:${PN}:remove:client = "stunnel.service"

RDEPENDS:${PN}:remove = "perl"
