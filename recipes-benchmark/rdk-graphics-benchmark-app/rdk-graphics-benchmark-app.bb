LICENSE = "CLOSED"
SUMMARY = "RDK graphics benchmark app"
DESCRIPTION = "rdkmark is a benchmark for the OpenGL (ES) 2.0 and Vulkan graphics APIs used RDK"
HOMEPAGE = "https://github.com/rdk-e/rdk-graphics-benchmark-app"

REQUIRED_DISTRO_FEATURES = "opengl vulkan wayland"
DEPENDS += "assimp glm libpng jpeg glslang-native libxkbcommon virtual/libgles2 virtual/egl vulkan-headers vulkan-loader wayland wayland-protocols wayland-native shaderc-native libdrm"

#DEPENDS:append:skyxione = " rtkmali"
#DEPENDS:append:xione-sercomm = " virtual/libgles1 virtual/libgles2 virtual/egl "
#DEPENDS:append:apache-4k = " virtual/libgles2 virtual/egl  "

SRC_URI = "git://git@github.com/rdk-e/rdk-graphics-benchmark-app;protocol=ssh;branch=main"
#SRC_URI += "file://final_egl_vk_changes.patch"
#SRC_URI += "file://0001_kms_vulkan_changes.patch"

SRCREV = "${AUTOREV}"
S = "${WORKDIR}/git"

inherit cmake pkgconfig features_check

do_install() {
    install -d ${D}${bindir}
    cp ${WORKDIR}/build/src/rdkmark ${D}${bindir}

    install -d ${D}${datadir}/rdkmark/shaders
    cp -r ${WORKDIR}/build/data/shaders/* ${D}${datadir}/rdkmark/shaders

    install -d ${D}${datadir}/rdkmark/textures
    cp -r ${WORKDIR}/build/data/textures/* ${D}${datadir}/rdkmark/textures

    install -d ${D}${datadir}/rdkmark/models
    cp -r ${WORKDIR}/build/data/models/* ${D}${datadir}/rdkmark/models

#    install -d ${D}${datadir}/rdkmark/scenes
#    cp -r ${WORKDIR}/build/data/scenes/* ${D}${datadir}/rdkmark/scenes
}

FILES:${PN} += "\
    ${bindir} \
    ${datadir} \
    "

