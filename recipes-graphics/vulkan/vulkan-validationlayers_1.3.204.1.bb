require vulkan-validationlayers.inc

SRCREV = "26dc8574c8ceafc901e1bbd7a0929da7e0a5df20"
PV = "1.3.204.1"

# Ninja can end up with a dependency on host path /usr/lib/librt.so (or
# /usr/lib64/librt.so), which does not exist in the build environment. Rewrite
# build.ninja to use the target sysroot path so the dependency resolves.
do_configure:append() {
    if [ -f ${B}/build.ninja ]; then
        sed -i "s|/usr/lib64/librt\.so|${STAGING_DIR_HOST}${libdir}/librt.so|g" ${B}/build.ninja
        sed -i "s|/usr/lib/librt\.so|${STAGING_DIR_HOST}${libdir}/librt.so|g" ${B}/build.ninja
    fi
}
