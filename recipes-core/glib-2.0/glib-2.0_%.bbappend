#RDK-46317
RDEPENDS:${PN}-dev += " libpcre-dev libffi-dev"

inherit breakpad-wrapper

#RDK-53880
CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"

# glib-2.0-dev RDEPENDS on libpcre-dev; glib-2.0-codegen on python3/python3-packaging/python3-xml.
# These are runtime-only deps not listed in DEPENDS. Suppress per-package QA.
# glib-2.0-dbg has absolute build paths in debug info (buildpaths QA).
INSANE_SKIP:${PN}-dev += "build-deps"
INSANE_SKIP:${PN}-codegen += "build-deps"
INSANE_SKIP:${PN}-dbg += "buildpaths"
INSANE_SKIP:${PN}-ptest += "build-deps"
