require recipes-devtools/rust-${PV}/rust-source-${PV}.inc
require recipes-devtools/rust-${PV}/rust-snapshot-${PV}.inc
FILESEXTRAPATHS:prepend := "${THISDIR}/cargo-${PV}:"
require cargo-cross-canadian.inc
