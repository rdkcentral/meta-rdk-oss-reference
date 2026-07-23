SUMMARY = "Vulkan Utilities and Tools"
DESCRIPTION = "Assist development by enabling developers to verify their application's correct use of the Vulkan API."
HOMEPAGE = "https://www.khronos.org/vulkan/"
BUGTRACKER = "https://github.com/KhronosGroup/Vulkan-Tools"
SECTION = "libs"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI = "git://github.com/KhronosGroup/Vulkan-Tools.git;branch=main;protocol=https"

inherit cmake features_check pkgconfig

# Wayland is required for vulkan-tools (e.g. vkcube) on RDKE
REQUIRED_DISTRO_FEATURES = "vulkan wayland"

DEPENDS += " \
    vulkan-headers \
    vulkan-loader \
    wayland \
    wayland-protocols \
    wayland-native \
    glslang-native \
"
RDEPENDS:${PN} += "vulkan-loader"

EXTRA_OECMAKE = "\
    -DBUILD_TESTS=OFF \
    -DBUILD_CUBE=ON \
    -DPYTHON_EXECUTABLE=${HOSTTOOLS_DIR}/python3 \
    -DCUBE_WSI_SELECTION=WAYLAND \
"

PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'wayland x11', d)}"

PACKAGECONFIG[x11] = "-DBUILD_WSI_XLIB_SUPPORT=ON -DBUILD_WSI_XCB_SUPPORT=ON, -DBUILD_WSI_XLIB_SUPPORT=OFF -DBUILD_WSI_XCB_SUPPORT=OFF, libxcb libx11 libxrandr"
PACKAGECONFIG[wayland] = "-DBUILD_WSI_WAYLAND_SUPPORT=ON, -DBUILD_WSI_WAYLAND_SUPPORT=OFF, wayland wayland-protocols wayland-native"

UPSTREAM_CHECK_GITTAGREGEX = "sdk-(?P<pver>\d+(\.\d+)+)"

FILES:${PN} = " \
    ${bindir}/vulkaninfo \
    ${bindir}/vkcube \
"

do_install:append() {
    rm -f ${D}${bindir}/vkcubepp || true
    rm -f ${D}${bindir}/vkcube-wayland || true
}
