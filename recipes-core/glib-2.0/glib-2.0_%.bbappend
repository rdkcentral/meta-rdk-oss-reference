#RDK-46317
RDEPENDS:${PN}-dev += " libpcre-dev libffi-dev"

inherit breakpad-wrapper

#RDK-53880
CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"
