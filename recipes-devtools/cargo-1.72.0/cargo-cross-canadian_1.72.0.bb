require recipes-devtools/rust-1.72.0/rust-source-${PV}.inc
require recipes-devtools/rust-1.72.0/rust-snapshot-${PV}.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/cargo-1.72.0:"

require cargo-cross-canadian.inc
