#RDK-46317
RDEPENDS:${PN}-dev += " libpcre-dev libffi-dev"

inherit breakpad-wrapper

#RDK-53880
CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"

# wrynose: glib-2.0-dbg debug symbols contain TMPDIR paths - -ffile-prefix-map doesn't cover all DWARF sections in meson builds
INSANE_SKIP:glib-2.0-dbg:append = " buildpaths"
