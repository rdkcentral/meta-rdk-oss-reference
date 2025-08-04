SUMMARY = "cargo applet to build and install C-ABI compatible dynamic and static libraries."
HOMEPAGE = "https://crates.io/crates/cargo-c"
LICENSE = "MIT"
LIC_FILES_CHKSUM = " \
    file://LICENSE;md5=384ed0e2e0b2dac094e51fbf93fdcbe0 \
"

SRC_URI += "crate://crates.io/cargo-c/${PV};sha256sum=516e8c3f59af4f1c2571abf539fe26384d4ee12b3bc91dc32c00a0c6efb1a8a2"

inherit cargo pkgconfig native

DEPENDS = "openssl curl"

require ${BPN}-crates.inc
