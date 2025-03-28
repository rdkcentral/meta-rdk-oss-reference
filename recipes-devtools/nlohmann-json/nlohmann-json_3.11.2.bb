SUMMARY = "JSON for modern C++"
HOMEPAGE = "https://nlohmann.github.io/json/"
SECTION = "libs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=f969127d7b7ed0a8a63c2bbeae002588"

SRC_URI = "git://github.com/nlohmann/json.git;nobranch=1"

SRCREV = "bc889afb4c5bf1c0d8ee29ef35eaaf4c8bef8a5d"

S = "${WORKDIR}/git"

inherit cmake

EXTRA_OECMAKE += "-DJSON_BuildTests=OFF"

# nlohmann-json is a header only C++ library, so the main package will be empty.

RDEPENDS:${PN}-dev = ""

BBCLASSEXTEND = "native nativesdk"

# other packages commonly reference the file directly as "json.hpp"
# create symlink to allow this usage
do_install:append() {
    ln -s nlohmann/json.hpp ${D}${includedir}/json.hpp
}
