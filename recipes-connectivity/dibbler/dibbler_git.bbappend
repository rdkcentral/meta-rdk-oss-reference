FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://0001-dibbler-crash-fix-for-dunfell.patch \
            file://RDKB-33761_IPv6_delegation.patch \
            file://0001-dibbler-force-UTC.patch"

CXXFLAGS:append = " -Os "

SRC_URI:append:kirkstone = " file://DELIA-34037-Dibbler-client-crash-in-delete_radvd_conf_kirkstone.patch \
                             file://0002-port-dibbler-patches-from-1.0.0_RC2-for-kirkstone.patch \
                           "

SRC_URI:append:client = " file://0001-RDK-32168-Set-default-log-path-for-dibbler-client.patch "

SRC_URI:append:broadband:kirkstone = " file://dhcpv6c_handle_system_time_change_kirkstone.patch \
                                       file://Fix-For-Dibbler-Crash-InNobinding-Rebinding-Solicit-Transition_kirkstone.patch"

#SRC_URI:append:broadband = " file://Fix-Dibbler-IPv6-Resolve-Conf-Expiry-Event-Alignment.patch"
SRC_URI:append:kirkstone = " file://0001-TOptIAPrefix-args-in-TClntOptIA_PD-constructor_kirk.patch"
SRC_URI:append:kirkstone = " file://0001-fix-misguided-and-broken-usage-of-clock_gettime-CLOC.patch"

