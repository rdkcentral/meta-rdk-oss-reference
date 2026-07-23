DEPENDS:remove = "libunistring"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "file://CVE-2024-0553_3.3.30_fix.patch \
                  file://CVE-2021-4209_3.3.30_fix.patch \
                 "

# GCC 14+ treats -Wformat-contains-nul as an error in libopts/usage.c
CFLAGS:append:wrynose = " -Wno-error=format-contains-nul"
