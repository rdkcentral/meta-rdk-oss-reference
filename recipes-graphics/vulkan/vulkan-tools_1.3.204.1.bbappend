FILESEXTRAPATHS:prepend := "${THISDIR}/vulkan-tools:"

inherit pkgconfig

DEPENDS:append = " glslang-native"
RDEPENDS:${PN} += "vulkan-loader"

#SRC_URI:append = " file://0001-vulkan-tools-cube-Yocto-cross-build-and-optional-xdg.patch"

EXTRA_OECMAKE:append = " -DBUILD_CUBE=ON"
EXTRA_OECMAKE:append = " -DCUBE_WSI_SELECTION=WAYLAND"

PACKAGECONFIG[wayland] = "-DBUILD_WSI_WAYLAND_SUPPORT=ON, -DBUILD_WSI_WAYLAND_SUPPORT=OFF, wayland wayland-protocols wayland-native"

FILES:${PN} += " \
    ${bindir}/vulkaninfo \
    ${bindir}/vkcube \
"

do_install:append() {
    rm -f ${D}${bindir}/vkcubepp || true
    rm -f ${D}${bindir}/vkcube-wayland || true
}
