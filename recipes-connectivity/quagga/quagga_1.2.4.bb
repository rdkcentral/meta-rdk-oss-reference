SUMMARY = "quagga routing daemons (wrynose dependency stub)"
DESCRIPTION = "BGP/OSPF/RIP routing daemon suite"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

PV = "1.2.4"
PR = "r0"

PACKAGES = "${PN} ${PN}-ripd ${PN}-ripngd"

ALLOW_EMPTY:${PN} = "1"
ALLOW_EMPTY:${PN}-ripd = "1"
ALLOW_EMPTY:${PN}-ripngd = "1"
