DEPENDS:remove = "libunistring"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "file://CVE-2024-0553_3.3.30_fix.patch \
                  file://CVE-2021-4209_3.3.30_fix.patch \
                 "
