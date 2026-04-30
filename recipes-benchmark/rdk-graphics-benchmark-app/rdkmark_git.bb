LICENSE = "CLOSED"
SUMMARY = "RDK graphics benchmark app"
DESCRIPTION = "rdkmark is a benchmark for the OpenGL (ES) 2.0 and Vulkan graphics APIs used RDK"
HOMEPAGE = "https://github.com/rdk-e/rdk-graphics-benchmark-app"

# Build OpenGL unconditionally; enable Vulkan only when DISTRO_FEATURES contains "vulkan".
REQUIRED_DISTRO_FEATURES = "opengl wayland rdkmark"

DEPENDS += "assimp glm libpng jpeg libxkbcommon virtual/libgles2 virtual/egl wayland wayland-protocols wayland-native libdrm"
DEPENDS:append = "${@bb.utils.contains('DISTRO_FEATURES','vulkan',' vulkan-headers vulkan-loader glslang-native shaderc-native','',d)}"

EXTRA_OECMAKE:append = " -DRDKMARK_BUILD_OPENGL=ON -DRDKMARK_BUILD_VULKAN=${@bb.utils.contains('DISTRO_FEATURES','vulkan','ON','OFF',d)}"

#DEPENDS:append:skyxione = " rtkmali"
#DEPENDS:append:xione-sercomm = " virtual/libgles1 virtual/libgles2 virtual/egl "
#DEPENDS:append:apache-4k = " virtual/libgles2 virtual/egl  "

SRC_URI = "git://git@github.com/rdk-e/rdk-graphics-benchmark-app;protocol=ssh;branch=main"

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

    install -d ${D}${datadir}/rdkmark/scenes
    cp -r ${WORKDIR}/build/data/scenes/* ${D}${datadir}/rdkmark/scenes
}

FILES:${PN} += "\
    ${bindir} \
    ${datadir} \
    "
