FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://Update-Addr-cache-for-confirmMessage.patch \
            file://0001-dibbler-crash-fix-for-dunfell.patch \
            file://RDKB-33761_IPv6_delegation.patch \
            file://0001-dibbler-force-UTC.patch"

CXXFLAGS:append = " -Os "
# wrynose OE6/GCC-15: Portable.h:256 uses 'return LOWLEVEL_ERROR_FILE' in a void function.
# GCC-15 promotes -Wreturn-mismatch to error. Suppress for this frozen dead codebase.
CXXFLAGS:append:wrynose = " -Wno-return-mismatch "
CFLAGS:append:wrynose = " -Wno-return-mismatch "

# wrynose OE6: kirkstone portability patches apply with fuzz (offset/context shift ok)
# patch-status: Pending patches predate OE6 Upstream-Status URL requirement
ERROR_QA:remove = "patch-fuzz patch-status"

# wrynose OE6: dibbler is end-of-life; wrynose uses same frozen codebase as kirkstone.
# Apply the same kirkstone portability patches for wrynose too.
SRC_URI:append:kirkstone = " file://DELIA-34037-Dibbler-client-crash-in-delete_radvd_conf_kirkstone.patch \
                             file://0002-port-dibbler-patches-from-1.0.0_RC2-for-kirkstone.patch \
                           "
SRC_URI:append:wrynose = " file://DELIA-34037-Dibbler-client-crash-in-delete_radvd_conf_kirkstone.patch \
                           file://0002-port-dibbler-patches-from-1.0.0_RC2-for-kirkstone.patch \
                         "

SRC_URI:append:client = " file://0001-RDK-32168-Set-default-log-path-for-dibbler-client.patch "

SRC_URI:append:broadband:kirkstone = " file://dhcpv6c_handle_system_time_change_kirkstone.patch \
                                       file://Fix-For-Dibbler-Crash-InNobinding-Rebinding-Solicit-Transition_kirkstone.patch \
                                       file://rfc3315-fix-unicast-request-and-client-IANA-options.patch"
SRC_URI:append:broadband:wrynose = " file://dhcpv6c_handle_system_time_change_kirkstone.patch \
                                     file://Fix-For-Dibbler-Crash-InNobinding-Rebinding-Solicit-Transition_kirkstone.patch \
                                     file://rfc3315-fix-unicast-request-and-client-IANA-options.patch"

#SRC_URI:append:broadband = " file://Fix-Dibbler-IPv6-Resolve-Conf-Expiry-Event-Alignment.patch"
SRC_URI:append:kirkstone = " file://0001-TOptIAPrefix-args-in-TClntOptIA_PD-constructor_kirk.patch"
SRC_URI:append:kirkstone = " file://0001-fix-misguided-and-broken-usage-of-clock_gettime-CLOC.patch"
SRC_URI:append:wrynose = " file://0001-TOptIAPrefix-args-in-TClntOptIA_PD-constructor_kirk.patch"
SRC_URI:append:wrynose = " file://0001-fix-misguided-and-broken-usage-of-clock_gettime-CLOC.patch"
# wrynose OE6: Configurable-WanName patches assume internal comcast setDUID body
# that does not exist in upstream dibbler source. Limit to kirkstone only (dibbler is dead).
SRC_URI:append:broadband:kirkstone = " file://Configurable-WanName-Support.patch"
SRC_URI:append:broadband:kirkstone = " file://Configurable-WanName-NotifyScript-mapT.patch"
