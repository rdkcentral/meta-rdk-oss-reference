require recipes-graphics/vulkan/vulkan-headers.inc
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=1bc355d8c4196f774c8b87ed1a8dd625"
SRCREV = "6a74a7d65cafa19e38ec116651436cce6efd5b2e"
PV = "1.4.303"

FILESEXTRAPATHS:prepend := "${THISDIR}/vulkan-headers:"
SRC_URI:append = " file://0001-Add-operator-eq-and-neq-to-all-handle-classes.patch"

PACKAGES := "${PN} ${PN}-dev"
