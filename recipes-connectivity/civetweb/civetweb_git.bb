SUMMARY = "Civetweb embedded web server"
SECTION = "libs"
DESCRIPTION = "C/C++ embeddable web server with optional CGI, SSL and Lua support."
HOMEPAGE = "https://github.com/civetweb/civetweb"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=da079d81be91ff1d1ca56dcd751f897f"

SRC_URI = "git://github.com/civetweb/civetweb.git"
SRC_URI += "file://0001-civetweb-build-lib-only.patch"
SRCREV = "0f1b43536d97d9311c73b658b86a9d44be9e5e82"
PV = "1.10+git+${SRCPV}"
S = "${WORKDIR}/git"

inherit pkgconfig cmake

EXTRA_OECMAKE = " \
    -DBUILD_SHARED_LIBS=ON \
    -DCIVETWEB_ENABLE_DUKTAPE=OFF \
    -DCIVETWEB_ENABLE_LUA=OFF \
    -DCIVETWEB_ENABLE_ASAN=OFF \
    -DCIVETWEB_BUILD_TESTING=OFF \
"

PACKAGECONFIG ??= "ipv6"
PACKAGECONFIG[ipv6] = "-DCIVETWEB_ENABLE_IPV6=ON,-DCIVETWEB_ENABLE_IPV6=OFF,"


#In the latest SRCREV of Civetweb, the CMakeLists.txt comes with CMAKE_INSTALL_LIBDIR instead of hard coded "lib".
#The below do_configure:prepend should be removed upon upgrading the Civetweb
do_configure:prepend:mixmode() {
    if [ -f ${S}/src/CMakeLists.txt ];then
        sed -i 's/DESTINATION lib/DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' ${S}/src/CMakeLists.txt
    fi
}

FILES:${PN} += " \
        ${libdir}/*.so \
"

INSANE_SKIP:${PN} += "dev-so"

