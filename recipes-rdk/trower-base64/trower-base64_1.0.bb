SUMMARY = "C implementation of base64 encode/decode"
HOMEPAGE = "https://github.com/Comcast/trower-base64"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b1e01b26bacfc2232046c90a330332b3"

SRCREV = "fbb9440ae2bc1118866baefcea7ff814f16613dd"
SRC_URI = "git://github.com/Comcast/trower-base64.git;branch=main"

S = "${WORKDIR}/git"

inherit pkgconfig cmake

EXTRA_OECMAKE += "-DBUILD_TESTING=OFF"

#In the latest SRCREV of trower-base64, meson is used instead of Cmake.
#The below do_configure:prepend should be removed upon upgrading the trower-base64
do_configure:prepend:mixmode() {
    if [ -f ${S}/src/CMakeLists.txt ];then
        sed -i 's/DESTINATION lib/DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' ${S}/src/CMakeLists.txt
    fi
}

FILES:${PN} += " \
        ${libdir}/*.so \
"
FILES_SOLIBSDEV = ""
INSANE_SKIP:${PN} = "dev-so"
