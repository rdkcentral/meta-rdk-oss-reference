SUMMARY = "A minimalist Machines implementation in ECMAScript executed by Duktape"
DESCRIPTION = "A minimalist Machines implementation in ECMAScript that's executed by Duktape and wrapped in a C library"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

SECTION = "libs"

DEPENDS = "duktape vim-native coreutils-native"


SRC_URI = "git://github.com/Comcast/littlesheens.git;protocol=https;branch=master;nobranch=1"
SRCREV = "${AUTOREV}"
PV := "${PV}+${SRCPV}"

CFLAGS:append = " -I${STAGING_INCDIR}/duktape"
# GCC 15 C23: conflicting types for mach_clear_spec_cache (int(int) vs int())
CFLAGS:append:wrynose = " -std=gnu11"

inherit pkgconfig cmake

EXTRA_OECMAKE = "-DTARGET_PLATFORM=yocto"
