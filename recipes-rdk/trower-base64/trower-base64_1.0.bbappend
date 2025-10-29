do_install:append() {
    install -d ${D}${includedir}/trower-base64
    install -m 0644 ${WORKDIR}/git/src/base64.h ${D}${includedir}/trower-base64/

    install -d ${D}${libdir}
    install -m 0644 ${B}/src/libtrower-base64.so.1.0.0 ${D}${libdir}/
    ln -sf libtrower-base64.so.1.0.0 ${D}${libdir}/libtrower-base64.so.0
    ln -sf libtrower-base64.so.1.0.0 ${D}${libdir}/libtrower-base64.so
}

FILES:${PN}-dev += "${includedir}/trower-base64"

BBCLASSEXTEND = "native"
