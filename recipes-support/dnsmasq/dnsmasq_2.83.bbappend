
FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}-${PV}:"

# Warning: RDK-B requires these changes to dnsmasq. If an RDK-B based build
# is using an alternative version of dnsmasq (a version to which these patches
# have not been ported) then expect runtime issues or missing functionality.

SRC_URI_remove = "file://130-fingerprint-dhcp-lease-file.patch"

SRC_URI_append_broadband = "  file://RDKCENTRAL_XDNS_core.patch \
                              file://RDKCENTRAL_Secondary_XDNS.patch \
                              file://RDKCENTRAL_dnsmasq_zombie_fix.patch \
                              file://RDKCENTRAL_XDNS_PROTECT_BROWSING_FIX.patch \
                              file://RDKCENTRAL_XDNS_LOG.patch \
                              file://RDKCENTRAL_XDNS_Refactor.patch \
                              file://RDKCENTRAL_XDNS_Enable_IPV6.patch  "

SRC_URI_append_broadband += " ${@bb.utils.contains('DISTRO_FEATURES', 'bci', 'file://RDKCENTRAL_MultiProfile_XDNS.patch', '', d)}"

SRC_URI_append_broadband += " ${@bb.utils.contains('DISTRO_FEATURES', 'device_gateway_association', 'file://ManageableDevice.patch', '', d)}"

SRC_URI_append_broadband += " ${@bb.utils.contains('DISTRO_FEATURES', 'vendor_class_id_feature', 'file://vendor_class_id.patch', '', d)}"

SRC_URI += "file://130-fingerprint-dhcp-lease-file-V2.83.patch \
            file://client_notify.patch"
SRC_URI += "file://CVE-2021-3448.patch"
SRC_URI += "file://CVE-2022-0934_fix.patch"

SRC_URI += " \
             file://0001-Move-fd-into-frec_src-fixes-15b60ddf935a531269bb8c68.patch \
             file://0001-Fix-to-75e2f0aec33e58ef5b8d4d107d821c215a52827c.patch \
             file://0001-Fix-for-12af2b171de0d678d98583e2190789e544440e02.patch \
             file://0001-Fix-problem-with-DNS-retries-in-2.83-2.84.patch \
             file://0001-Simplify-preceding-fix.patch \
             "

do_install_append() {
    sed -i -- 's/listen-address=127.0.0.1/#listen-address=127.0.0.1/g' ${D}${sysconfdir}/dnsmasq.conf
    sed -i -- 's/bind/#Remove this statement/g' ${D}${sysconfdir}/dnsmasq.conf
}

