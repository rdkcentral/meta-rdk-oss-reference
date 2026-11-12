FILESEXTRAPATHS:prepend := "${THISDIR}/vulkan-tools:"
SRC_URI:append = " file://0002-vulkan-tools-cmake-fix.patch"

EXTRA_OECMAKE:append = " \
-DWAYLAND_CLIENT_PATH=${STAGING_DATADIR}/wayland \
"

EXTRA_OECMAKE:append = " \
-DWAYLAND_SCANNER_EXECUTABLE=${STAGING_BINDIR_NATIVE}/wayland-scanner \
"
