FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:broadband = "  \
                             file://0001-add-extentions-for-http-match-rule-specifications.patch \
                             ${@bb.utils.contains('DISTRO_FEATURES', 'nat46', 'file://iptables-connlimit-daddr-dport.patch', '', d)} \
                             file://0001-add-port-triggering-support.patch \
                             file://0001-extenstions-http.patch \
                           "

# this file is already provided by sysint, which is not right
# right way would be to write a iptable bbappend and add it via
# that, but for now lets remove iptables to be provider of this
# file for rdk
#
do_install:append() {
	rm -rf ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:iptables:remove = "iptables.service ip6tables.service"
