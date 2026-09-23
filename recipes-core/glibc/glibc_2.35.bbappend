FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#From meta-rdk-ext
FULL_OPTIMIZATION:remove = "-Os"
FULL_OPTIMIZATION:append = "-O2"


SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://size.patch','',d)} "

SRC_URI += " file://CVE-2025-15281_2.35_fix.patch \
	     file://CVE-2026-0915_2.35_fix.patch \
	     file://CVE-2026-4046_2.35_fix.patch \
	     file://CVE-2026-5450_2.35_fix.patch \
	     file://CVE-2026-5928_2.35_fix.patch \
	    "
