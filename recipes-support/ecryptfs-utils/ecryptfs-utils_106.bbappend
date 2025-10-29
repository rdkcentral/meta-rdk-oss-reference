FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://CVE-2015-8946_fix.patch \
            file://CVE-2016-1572_fix.patch \
            file://CVE-2016-6224_fix.patch \
" 

TARGET_CFLAGS:append = " -Wno-deprecated-declarations -Wno-implicit-function-declaration"

INSANE_SKIP:${PN} += "installed-vs-shipped"
