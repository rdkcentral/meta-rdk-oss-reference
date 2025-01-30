FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:remove = "file://enforce-use-stl.patch"
SRC_URI:append = " file://tinyxml.pc "

LDFLAGS += "tinystr.o"

do_compile:prepend() {
	${CXX} ${CXXFLAGS} ${EXTRA_CXXFLAGS} -c -o tinystr.o tinystr.cpp
}

do_install:append() {
	install -m 0644 ${S}/tinystr.h ${D}${includedir}
        install -Dm 644 ${B}/../tinyxml.pc ${D}${libdir}/pkgconfig/tinyxml.pc
}
