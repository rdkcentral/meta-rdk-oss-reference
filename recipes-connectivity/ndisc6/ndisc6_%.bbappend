FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += '${@bb.utils.contains("DISTRO_FEATURES", "morty", "file://rdnssd-temp-resolv-file-write-issue-fix.patch", "file://rdnssd-temp-resolv-file-write-issue-fix-dunfell.patch", d)}'

