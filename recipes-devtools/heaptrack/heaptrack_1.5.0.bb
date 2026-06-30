SUMMARY = "Heap memory profiler for Linux"
DESCRIPTION = "Heaptrack traces all memory allocations and annotates these \
events with stack traces. Dedicated analysis tools then allow you to interpret \
the heap memory profile to find hotspots to reduce memory, leaks, allocation \
hotspots and temporary allocations"
HOMEPAGE = "https://phabricator.kde.org/source/heaptrack/"
#LICENSE = "LGPL-2.1-only"
#LIC_FILES_CHKSUM = "file://README.md;md5=4ef5b760f4d060d021f18b2ecd154ee5"
LICENSE = "LGPL-2.1-or-later & GPL-2.0-or-later & BSD-3-Clause & Apache-2.0 & MIT"

DEPENDS = "zlib boost libunwind elfutils zstd"
RDEPENDS:${PN} += "bash"


SRC_URI = "git://github.com/KDE/heaptrack.git;protocol=https;branch=master \
        "
SRCREV = "c8bbebd325f41dd34af409b68eb3eaa619e326cf"

SRC_URI += "file://remove_zstd_depends.patch \
            file://add_tid_in_heaptrack.patch \
            file://libunwind-backtrace-optional.patch \
            file://copy_Debugrootfs.sh \
            file://boost190-drop-system-component.patch "

TARGET_CC_ARCH += "${LDFLAGS}"

inherit cmake

EXTRA_OECMAKE += "-DHEAPTRACK_BUILD_PRINT=ON -DHEAPTRACK_BUILD_GUI=ON -DHEAPTRACK_BUILD_BACKTRACE=OFF"
# wrynose/cmake-4.x: robin-map sub-project has old cmake_minimum_required
# wrynose: Boost 1.90.0 cmake config layout changed; boost_system component not found; disable GUI
EXTRA_OECMAKE:wrynose = "-DHEAPTRACK_BUILD_PRINT=ON -DHEAPTRACK_BUILD_GUI=OFF -DHEAPTRACK_BUILD_BACKTRACE=OFF -DCMAKE_POLICY_VERSION_MINIMUM=3.5"

do_install:append() {
install -d ${D}${base_libdir}/rdk
install -d ${D}/${includedir}
install -m 0755 ${S}/src/track/libheaptrack.h ${D}/${includedir}/libheaptrack.h
# wrynose/usrmerge: use ${base_libdir} instead of /lib
install -m 0755 ${UNPACKDIR}/copy_Debugrootfs.sh ${D}${base_libdir}/rdk
}

FILES:${PN} += " ${base_libdir}/rdk/copy_Debugrootfs.sh"
BBCLASSEXTEND = "native nativesdk"
