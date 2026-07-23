SUMMARY = "Heap memory profiler for Linux"
DESCRIPTION = "Heaptrack traces all memory allocations and annotates these \
events with stack traces. Dedicated analysis tools then allow you to interpret \
the heap memory profile to find hotspots to reduce memory, leaks, allocation \
hotspots and temporary allocations"
HOMEPAGE = "https://phabricator.kde.org/source/heaptrack/"
#LICENSE = "LGPL-2.1-only"
#LIC_FILES_CHKSUM = "file://README.md;md5=4ef5b760f4d060d021f18b2ecd154ee5"
LICENSE = "LGPL-2.1-or-later & GPL-2.0-or-later & BSD-3-Clause & Apache-2.0 & MIT"
LIC_FILES_CHKSUM = "file://LICENSES/LGPL-2.1-only.txt;md5=41890f71f740302b785c27661123bff5 \
                    file://LICENSES/GPL-2.0-or-later.txt;md5=3d26203303a722dedc6bf909d95ba815 \
                    file://LICENSES/BSD-3-Clause.txt;md5=f225922a2c12dfa5218fb70c49db3ea6 \
                    file://LICENSES/Apache-2.0.txt;md5=c846ebb396f8b174b10ded4771514fcc \
                    file://LICENSES/MIT.txt;md5=7dda4e90ded66ab88b86f76169f28663"

DEPENDS = "zlib boost libunwind elfutils zstd"
RDEPENDS:${PN} += "bash"


SRC_URI = "git://github.com/KDE/heaptrack.git;protocol=https;branch=master \
        "
SRCREV = "c8bbebd325f41dd34af409b68eb3eaa619e326cf"

SRC_URI += "file://remove_zstd_depends.patch \
            file://add_tid_in_heaptrack.patch \
            file://copy_Debugrootfs.sh "


TARGET_CC_ARCH += "${LDFLAGS}"

inherit cmake

# cmake 4.3 FindLibunwind.cmake cross-compilation: UNW_BACKTRACE link test fails
# on aarch64 even though libunwind 1.8 has the symbol — pre-set the cache var.
EXTRA_OECMAKE += "-DHEAPTRACK_BUILD_PRINT=OFF -DHEAPTRACK_BUILD_GUI=OFF -DHEAPTRACK_BUILD_BACKTRACE=OFF -DLIBUNWIND_HAS_UNW_BACKTRACE=TRUE"

do_install:append() {
install -d ${D}${base_libdir}/rdk
install -d ${D}/${includedir}
install -m 0755 ${S}/src/track/libheaptrack.h ${D}/${includedir}/libheaptrack.h
install -m 0755 ${UNPACKDIR}/copy_Debugrootfs.sh ${D}${base_libdir}/rdk
}

FILES:${PN} += " ${base_libdir}/rdk/copy_Debugrootfs.sh"
BBCLASSEXTEND = "native nativesdk"
