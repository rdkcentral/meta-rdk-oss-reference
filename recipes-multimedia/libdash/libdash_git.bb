SUMMARY = "libdash provides an object-oriented interface to the Dynamic Adaptive Streaming over HTTP (DASH) standard"
HOMEPAGE = "https://bitmovin.com/libdash/"
LICENSE = "LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://libdash/Authors.txt;md5=05b5aea0fa91d5816eb4383707c52b36"
SECTION = "libs"
FILESEXTRAPATHS:prepend := "${THISDIR}/libdash:"

SRCREV = "f5b5d991af5fe5f285e8040c997b755d3d456b0d"

PV = "1.0.0+git${SRCPV}"
PR = "r0"

SRC_URI = "git://github.com/bitmovin/libdash;branch=stable_3_0;protocol=https \
           file://libdash.pc \
           file://0001-libdash-build.patch \
           file://0002-libdash-starttime-uint64.patch \
           file://0003-libdash-presentationTimeOffset-uint64.patch \
           file://0004-Support-of-EventStream.patch \
           file://0006-RDK-32003-LLD-Support.patch \
	   file://0007-DELIA-51645-Event-Stream-RawAttributes-Support.patch \
           file://0008-DELIA-53263-Use-Label-TAG.patch \
	   file://0009-RDK-35134-Support-for-FailoverContent.patch \
	   file://0010-RDKAAMP-121-Failover-Tag-on-SegmentTemplate.patch \
	   file://0011-RDKAAMP-61-AAMP-low-latency-dash-stream-evaluation.patch \
           file://0012-To-retrieves-the-text-content-of-CDATA-section.patch \
          "

S = "${WORKDIR}/git/libdash"
DEPENDS += "libxml2 curl zlib"
inherit pkgconfig cmake
FILES:${PN} += "${libdir}/libdash.so"
# Workaround to have dev so to ${PN}. Ideally, the recipe should generate the versioned so file for ${PN}
FILES:${PN}-dev:remove = "/usr/lib/lib*.so"

do_install:append() {
	install -d ${D}${includedir}
	install -d ${D}${includedir}/libdash
	install -d ${D}${includedir}/libdash/xml
	install -d ${D}${includedir}/libdash/mpd
	install -d ${D}${includedir}/libdash/helpers
	install -d ${D}${includedir}/libdash/network
	install -d ${D}${includedir}/libdash/portable
	install -d ${D}${includedir}/libdash/metrics
	install -m 0644 ${S}/libdash/include/*.h ${D}${includedir}/libdash
	install -m 0644 ${S}/libdash/source/xml/*.h ${D}${includedir}/libdash/xml
	install -m 0644 ${S}/libdash/source/mpd/*.h ${D}${includedir}/libdash/mpd
	install -m 0644 ${S}/libdash/source/network/*.h ${D}${includedir}/libdash/network
	install -m 0644 ${S}/libdash/source/portable/*.h ${D}${includedir}/libdash/portable
	install -m 0644 ${S}/libdash/source/helpers/*.h ${D}${includedir}/libdash/helpers
	install -m 0644 ${S}/libdash/source/metrics/*.h ${D}${includedir}/libdash/metrics
	install -Dm644 ${WORKDIR}/libdash.pc ${D}${libdir}/pkgconfig/libdash.pc
}
