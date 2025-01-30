FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"

# Add egl/gles to config
PACKAGECONFIG:append:class-target = " egl glesv2"

PACKAGECONFIG:remove = "directfb"


SRC_URI += "file://0006-add-egl-device-create.patch"
SRC_URI += "file://0009-error-check-just-in-debug.patch"

SRC_URI += "file://0001-add-noaa-compositor-for-v1.16.patch"
SRC_URI += "file://0010-Fix-performance-and-memory-consumption-issue.patch"
SRC_URI += "file://cairo_scaled_font_destroy_Assertion.patch"
SRC_URI += "file://0011-fix-device-errors-for-glesv2-contexts.patch"
