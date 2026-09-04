
SUMMARY = "RDK graphics benchmark app"
DESCRIPTION = "Benchmarking tool to compare OpenGL ES 2.0 and Vulkan graphics performance on RDK"
HOMEPAGE = "https://github.com/rdk-e/rdk-graphics-benchmark-app"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

# Build OpenGL unconditionally; enable Vulkan only when DISTRO_FEATURES contains "vulkan".
REQUIRED_DISTRO_FEATURES = "opengl wayland rdkmark"

DEPENDS += "assimp glm libpng jpeg libxkbcommon virtual/libgles2 virtual/egl wayland wayland-protocols wayland-native libdrm"
DEPENDS:append = "${@bb.utils.contains('DISTRO_FEATURES','vulkan',' vulkan-headers vulkan-loader glslang-native shaderc-native','',d)}"

EXTRA_OECMAKE:append = " -DRDKMARK_BUILD_OPENGL=ON -DRDKMARK_BUILD_VULKAN=${@bb.utils.contains('DISTRO_FEATURES','vulkan','ON','OFF',d)}"

SRC_URI = "${RDKE_GITHUB_ROOT}/rdk-graphics-benchmark-app;protocol=${RDKE_GITHUB_PROTOCOL};branch=main"

SRCREV ?= "f5290a4d2d6978cc325496f793e764a8951d522c"
S = "${WORKDIR}/git"

inherit cmake pkgconfig features_check

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/src/rdkmark ${D}${bindir}/rdkmark

    install -d ${D}${datadir}/rdkmark/shaders
    cp -r ${B}/data/shaders/* ${D}${datadir}/rdkmark/shaders

    install -d ${D}${datadir}/rdkmark/textures
    cp -r ${B}/data/textures/* ${D}${datadir}/rdkmark/textures

    install -d ${D}${datadir}/rdkmark/models
    cp -r ${B}/data/models/* ${D}${datadir}/rdkmark/models

    install -d ${D}${datadir}/rdkmark/scenes
    cp -r ${B}/data/scenes/* ${D}${datadir}/rdkmark/scenes
}

FILES:${PN} += "\
    ${bindir} \
    ${datadir} \
    "
