SUMMARY = "JSON C++ lib used to read and write json file."
DESCRIPTION = "Jsoncpp is an implementation of a JSON (http://json.org) reader \
               and writer in C++. JSON (JavaScript Object Notation) is a \
               lightweight data-interchange format. It is easy for humans to \
               read and write. It is easy for machines to parse and generate."

HOMEPAGE = "http://sourceforge.net/projects/jsoncpp/"

SECTION = "libs"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://LICENSE;md5=fa2a23dd1dc6c139f35105379d76df2b"

SRC_URI = "git://github.com/open-source-parsers/jsoncpp.git \
           file://0001-Build-Issue-Fix-snprintf.patch \
"
SRC_URI = "git://github.com/open-source-parsers/jsoncpp;branch=master;protocol=https"

# release 1.8.4
#SRCREV = "ddabf50f72cf369bf652a95c4d9fe31a1865a781"
SRCREV = "ceae0e3867fe16e1227b4a39fe6951ee005591dc"

S = "${WORKDIR}/git"

EXTRA_OECMAKE += "-DBUILD_SHARED_LIBS=ON -DJSONCPP_WITH_PKGCONFIG_SUPPORT=OFF -DBUILD_TESTING=OFF -DJSONCPP_WITH_TESTS=OFF"

inherit cmake

BBCLASSEXTEND:append += " nativesdk"
do_install:append() {
    rm -rf ${D}${libdir}/objects-Release || true
}

