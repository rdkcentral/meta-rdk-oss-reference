LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"
PR = "r4"

require findutils.inc

SRC_URI = "${GNU_MIRROR}/${BPN}/${BP}.tar.gz \
           file://gnulib-extension.patch \
           file://findutils_fix_for_automake-1.12.patch \
           file://findutils-fix-doc-build-error.patch \
           "

SRC_URI[md5sum] = "a0e31a0f18a49709bf5a449867c8049a"
SRC_URI[sha256sum] = "e0d34b8faca0b3cca0703f6c6b498afbe72f0ba16c35980c10ec9ef7724d6204"

# wrynose-144: buildpaths in findutils (new OE6 check)
INSANE_SKIP:${PN}:append:wrynose = " buildpaths"
# wrynose/gcc-15: gnulib/lib/mktime.c compile-time array check fails in C23 mode
CFLAGS:append:wrynose = " -std=gnu11"
# wrynose: _TIME_BITS=64 (from GLIBC_64BIT_TIME_FLAGS via TARGET_CC_ARCH) makes time_t 64-bit on
# arm32, breaking old gnulib verify() assertions. Zero out the flags for this old recipe.
# CFLAGS:remove does NOT work because the flag comes from TARGET_CC_ARCH, not CFLAGS directly.
GLIBC_64BIT_TIME_FLAGS:wrynose = ""
INSANE_SKIP:${PN}:append:wrynose = " 32bit-time"
