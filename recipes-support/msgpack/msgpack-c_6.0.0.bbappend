do_install:append() {
    ln -sf libmsgpack-c.so ${D}${libdir}/libmsgpackc.so
}
