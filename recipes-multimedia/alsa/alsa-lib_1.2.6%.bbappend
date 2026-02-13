SRC_URI += "file://run-ptest"

inherit ptest

do_compile_ptest() {
    # We use the cross-compiler (${CC}) to build the C files found in the source
    ${CC} ${CFLAGS} "${S}/test/lsb/config.c" -I "${S}/include" -L "${B}/src/.libs/" -lasound ${LDFLAGS} -o ${B}/config
    ${CC} ${CFLAGS} "${S}/test/control.c" -I "${S}/include" -L "${B}/src/.libs/" -lasound ${LDFLAGS} -o ${B}/control
    ${CC} ${CFLAGS} "${S}/test/client_event_filter.c" -I "${S}/include" -L "${B}/src/.libs/" -lasound ${LDFLAGS} -o ${B}/client_event_filter
    ${CC} ${CFLAGS} "${S}/test/namehint.c" -I "${S}/include" -L "${B}/src/.libs/" -lasound ${LDFLAGS} -o ${B}/namehint
    ${CC} ${CFLAGS} "${S}/test/lsb/midi_event.c" -I "${S}/include" -L "${B}/src/.libs/" -lasound ${LDFLAGS} -o ${B}/midi_event
}

do_install_ptest() {
    install -m 0755 "${B}/config" "${D}${PTEST_PATH}"
    install -m 0755 "${B}/control" "${D}${PTEST_PATH}"
    install -m 0755 "${B}/client_event_filter" "${D}${PTEST_PATH}"
    install -m 0755 "${B}/midi_event" "${D}${PTEST_PATH}"
    install -m 0755 "${B}/namehint" "${D}${PTEST_PATH}"
}
