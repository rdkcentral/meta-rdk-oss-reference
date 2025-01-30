FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
## The below patch is required to use gssdp-1.2 with gupnp-1.0
SRC_URI:append = " file://0001-Use-gssdp-1.2.patch"

SRC_URI:append = " file://CVE-2021-33516_fix.patch "
