FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
   file://nice.cfg \
   file://viconsole.cfg \
   file://rdkb.cfg \
   file://shasum.cfg \
   file://tftp.cfg \
   file://netstat.cfg \
   file://tdk-needed-tools.cfg \
   file://telnet.cfg \
   file://date.cfg \
   file://ipneighbor.cfg \
   file://top.cfg \
   file://archival.cfg \
   file://traceroute.cfg \
   file://blkid.cfg \
   file://devmem.cfg \
   file://timeout.cfg \
   file://zcip.cfg \
   file://network-tools-removal.cfg \
   file://enable_ar.cfg \
   file://busybox-support-chinese-display.patch \
   ${VERSION_PATCHES} \
   file://0001-add-ENABLE_FEATURE_SYSTEMD-and-use-it-in-syslogd.patch \
   file://busybox-1.31-ping-mdev-support.patch \
   file://pgrep.cfg \
   "

SRC_URI:append:broadband = " file://enable_ps_wide.cfg"
SRC_URI:append:broadband = " file://strings.cfg"
SRC_URI:append:broadband = " file://Udhcpc_Early_Background.patch"

SRC_URI:remove:broadband += " \
   file://blkid.cfg \
   "

VERSION_PATCHES ?= ""
VERSION_PATCHES:append:client = " file://busybox-1.35-udhcp-trigger-milestones.patch"

PTEST_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', '1', '0', d)}"
inherit ptest-package-deploy
