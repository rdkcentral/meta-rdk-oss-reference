#RDK-46317
RDEPENDS:${PN}-dev += " libpcre-dev libffi-dev"

inherit breakpad-wrapper

#RDK-53880
CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"

# Avoid pulling in python3-distutils into the nativesdk dependency chain for glib
CODEGEN_PYTHON_RDEPENDS = "python3 python3-xml"
RDEPENDS:${PN}-codegen = "${CODEGEN_PYTHON_RDEPENDS}"
