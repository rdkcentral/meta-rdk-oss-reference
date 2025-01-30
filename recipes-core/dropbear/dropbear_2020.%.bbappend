FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://dropbear_2019-ssh_log.patch"
SRC_URI:append = " file://ssh_telemetry_2020.patch"

SRC_URI:append = " file://dropbear_2019-verbose.patch \
                   file://dropbear_2019-revsshipv6.patch \
                   file://dropbear_2019-Fixed-Race-Conditions-Observed-when-using-port-forwa.patch \
"

SRC_URI:append = " file://dropbear_performance__kirkstone_issue.patch \
                   file://CVE-2021-36369_dropbear_2020.81_fix.patch \
                   file://CVE-2023-48795_2020.81_fix.patch \
"
