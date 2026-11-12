require recipes-graphics/vulkan/vulkan-tools.inc

SRCREV = "4f965e1de79ba354fff816f1108cc25066847be0"
PV = "1.4.303"

SRC_URI += "file://0001-Disable-xdg-wm-base-related-code_new.patch"
DEPENDS += "vulkan-volk"
