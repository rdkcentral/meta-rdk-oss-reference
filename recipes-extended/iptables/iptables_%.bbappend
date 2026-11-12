# this file is already provided by sysint, which is not right
# right way would be to write a iptable bbappend and add it via
# that, but for now lets remove iptables to be provider of this
# file for rdk
#
do_install:append() {
	rm -rf ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:iptables:remove = "iptables.service ip6tables.service"


inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash util-linux ${PN}"

do_compile_ptest() {
    :
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests/shell
    cp -r ${S}/iptables/tests/shell/testcases ${D}${PTEST_PATH}/tests/shell/
    install -m 0755 ${S}/iptables/tests/shell/run-tests.sh ${D}${PTEST_PATH}/tests/shell/

    # Make all test scripts executable
    find ${D}${PTEST_PATH}/tests/shell/testcases -type f -exec chmod 0755 {} \;
}
