
FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}-${PV}:"

# Warning: RDK-B requires these changes to dnsmasq. If an RDK-B based build
# is using an alternative version of dnsmasq (a version to which these patches
# have not been ported) then expect runtime issues or missing functionality.


SRC_URI:append:broadband = "  file://RDKCENTRAL_XDNS_core.patch \
                              file://RDKCENTRAL_Secondary_XDNS.patch \
                              file://RDKCENTRAL_dnsmasq_zombie_fix.patch \
                              file://RDKCENTRAL_XDNS_PROTECT_BROWSING_FIX.patch \
                              file://RDKCENTRAL_XDNS_LOG.patch \
                              file://RDKCENTRAL_XDNS_Refactor.patch \
                              file://RDKCENTRAL_XDNS_Enable_IPV6.patch  "

SRC_URI:append:broadband += " ${@bb.utils.contains('DISTRO_FEATURES', 'bci', 'file://RDKCENTRAL_MultiProfile_XDNS.patch', '', d)}"

SRC_URI:append:broadband += " ${@bb.utils.contains('DISTRO_FEATURES', 'device_gateway_association', 'file://ManageableDevice.patch', '', d)}"


SRC_URI:append = " file://130-fingerprint-dhcp-lease-file-V2.90.patch \
                   file://client_notify.patch"

do_install:append() {
    sed -i -- 's/listen-address=127.0.0.1/#listen-address=127.0.0.1/g' ${D}${sysconfdir}/dnsmasq.conf
    sed -i -- 's/bind/#Remove this statement/g' ${D}${sysconfdir}/dnsmasq.conf
}
