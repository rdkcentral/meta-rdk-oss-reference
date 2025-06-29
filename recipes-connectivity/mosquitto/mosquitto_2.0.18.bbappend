FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://mosquitto_prefer_ipv4.patch"

PACKAGECONFIG:remove = " websockets"
SYSTEMD_AUTO_ENABLE:${PN} = "${@bb.utils.contains('MACHINE', 'arrisxb7atom-sdk72x', 'disable', 'enable', d)}"
