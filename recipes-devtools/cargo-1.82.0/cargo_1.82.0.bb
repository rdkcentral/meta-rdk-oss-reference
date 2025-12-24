
require recipes-devtools/rust-${PV}/rust-source-${PV}.inc
require recipes-devtools/rust-${PV}/rust-snapshot-${PV}.inc
require cargo.inc
BBCLASSEXTEND = "native nativesdk"
