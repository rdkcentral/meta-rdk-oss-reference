do_install:append:class-target() {
    sed -i -e 's:${STAGING_DIR_HOST}${libdir}/::g' \
        ${D}${libdir}/cmake/SPIRV-Tools/SPIRV-ToolsTarget.cmake
}
