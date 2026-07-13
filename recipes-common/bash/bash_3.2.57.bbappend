FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"
SRC_URI += "file://CVE-2016-7543.patch \
            file://CVE-2016-9401.patch \
            file://CVE-2019-9924.patch \
            file://CVE-2019-18276.patch \
"
TARGET_CFLAGS:append = " -std=gnu89"

CFLAGS:append = "  \
               -Wno-error=return-mismatch \
               -Wno-old-style-definition  \
              -Wno-format-zero-length \
"
TARGET_CFLAGS:append = "  \
               -Wno-error=deprecated-non-prototype \
               -Wno-error=strict-prototypes \
"

do_install:append() {
    rm -f ${D}${bindir}/bashbug
}
