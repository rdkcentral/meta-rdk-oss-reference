FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://CVE-2021-43618_4.2.1_fix.patch \
			file://gcc15-conftest-memcpy-prototype.patch \
			file://gcc15-longlong-conftest-prototypes.patch"
