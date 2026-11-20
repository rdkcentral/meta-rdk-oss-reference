FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"
CFLAGS:append = " -std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"
SRC_URI += "file://CVE-2016-7543.patch \
            file://CVE-2016-9401.patch \
            file://CVE-2019-9924.patch \
            file://CVE-2019-18276.patch \
            file://gcc15-list-reverse-prototype.patch \
            file://gcc15-posix-sighandler-return.patch \
            file://gcc15-siglist-header-order.patch \
"
