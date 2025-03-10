SUMMARY = "interface to seccomp filtering mechanism"
DESCRIPTION = "The libseccomp library provides and easy to use, platform independent,interface to the Linux Kernel's syscall filtering mechanism: seccomp."
SECTION = "security"
LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://LICENSE;beginline=0;endline=1;md5=8eac08d22113880357ceb8e7c37f989f"

SRCREV = "1dde9d94e0848e12da20602ca38032b91d521427"

SRC_URI = "git://github.com/seccomp/libseccomp.git;branch=release-2.4 \
           file://syscall_close_range.patch \
        "

S = "${WORKDIR}/git"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit autotools-brokensep pkgconfig ptest

PACKAGECONFIG ??= ""
PACKAGECONFIG[python] = "--enable-python, --disable-python, python"

DISABLE_STATIC = ""

do_compile_ptest() {
    oe_runmake -C tests check-build
}

FILES:${PN} = "${bindir} ${libdir}/${BPN}.so*"
