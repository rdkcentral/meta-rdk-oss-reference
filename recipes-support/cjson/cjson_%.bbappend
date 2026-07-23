do_install:append() {
        # Create symlink to support meta-rdk components which expect cJSON.h to
        # be found in the toplevel sysroot ${includedir} rather than within the
        # cjson subdirectory. Fixme: The real solution would be to fix those
        # recipes and then remove this symlink.
        ln -s cjson/cJSON.h ${D}${includedir}/cJSON.h
}


# OE6 wrynose: [build-deps] cmake is runtime-only for ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
