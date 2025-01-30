
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0003-Add-support-for-LD_PRELOAD-aliasing_v1.5.4.patch \
            file://0004-Make-graphic-libs-configurable_v1.5.4.patch \
"

REQUIRED_DISTRO_FEATURES_remove = "opengl"

