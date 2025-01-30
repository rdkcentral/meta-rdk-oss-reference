do_install:append() {
    rm -f ${D}${libdir}/libwayland-egl.so*
    rm -f ${D}${libdir}/pkgconfig/wayland-egl.pc
}

#Fix RDK-45546
FILES:${PN}-dev:remove = "${bindir}"
