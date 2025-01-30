SUMMARY = "Minizip"
DEPENDS = ""
LICENSE = "Zlib"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3fb541eb8359212703e21d14eba7ac64"

PV = "1.0.0+git${SRCPV}"
PR = "r0" 

SRC_URI = "git://github.com/nmoinvaz/minizip.git;branch=1.2;protocol=http"
SRCREV = "71ef99f6a051c11652502cf31cfef292de2e7736"

S = "${WORKDIR}/git"
B = "${WORKDIR}/git"

EXTRA_OECMAKE += "-DUSE_AES=OFF -DBUILD_SHARED_LIBS=ON"

DEPENDS += "zlib"
inherit cmake

do_install:append() {
    rm -r ${D}/usr/cmake
}

#In the latest SRCREV of minizip, the CMakeLists.txt comes with CMAKE_INSTALL_LIBDIR instead of hard coded "lib".
#The below do_configure:prepend should be removed upon upgrading the minizip
do_configure:prepend:mixmode() {
    sed -i 's/"lib"/"${CMAKE_INSTALL_LIBDIR}"/g' ${S}/CMakeLists.txt
}

FILES:${PN} += "${libdir}/*.so"
FILES_SOLIBSDEV = ""
INSANE_SKIP:${PN} += "dev-so"

BBCLASSEXTEND:append += " nativesdk"
