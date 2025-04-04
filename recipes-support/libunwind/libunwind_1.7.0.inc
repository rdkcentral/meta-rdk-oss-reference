SUMMARY = "Library for obtaining the call-chain of a program"
DESCRIPTION = "a portable and efficient C programming interface (API) to determine the call-chain of a program"
HOMEPAGE = "http://www.nongnu.org/libunwind"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=2d80c8ed4062b8339b715f90fa68cc9f"
DEPENDS += "libatomic-ops"
DEPENDS:append:libc-musl = " libucontext"

inherit autotools multilib_header

PACKAGECONFIG ??= ""

do_install:append () {
        oe_multilib_header libunwind.h
}

BBCLASSEXTEND = "native"
