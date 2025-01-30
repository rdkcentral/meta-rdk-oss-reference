do_install_append_dunfell() {
    rm -f ${D}${libdir}/libwayland-egl.so*
    rm -f ${D}${libdir}/pkgconfig/wayland-egl.pc
}

#Fix RDK-45546
FILES_${PN}-dev_remove = "${bindir}"
