FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://psplash-colors.h"

#     poky will build multiple psplash packages with 'outsuffix' in name for
#     each of these ...
SPLASH_IMAGES = "file://xfinity_splash_image.png;outsuffix=default"
