SUMMARY = "mustach - C library implementation of the mustache templating language"
DESCRIPTION = "A C library implementation of the mustache templating language"
SECTION = "libs"
HOMEPAGE = "https://gitlab.com/jobol/mustach"

LICENSE = "ISC"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=b26c29d2595093a3286f808cc8c91423"

MUSTACH_TAG = "1.2.2"

SRC_URI = "git://gitlab.com/jobol/mustach.git;protocol=https;nobranch=1"
SRCREV = "a65e3a24a40aa479879a03ff3d7fb4288af65ea6"


DEPENDS = "cjson"

inherit pkgconfig

do_install() {
    oe_runmake PREFIX=${prefix} DESTDIR=${D} install
}
