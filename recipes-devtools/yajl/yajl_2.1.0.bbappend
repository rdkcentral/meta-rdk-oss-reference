FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
ERROR_QA:remove = "patch-fuzz"
SRC_URI += " file://0002-math-link.patch "

