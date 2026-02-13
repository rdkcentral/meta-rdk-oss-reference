PACKAGECONFIG:remove = "bluez5"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit ptest

SRC_URI += "file://run-ptest"

do_compile_ptest() {
    oe_runmake -C ${B}/testprogs \
        capturetest can_set_rfmon_test filtertest \
        findalldevstest findalldevstest-perf opentest reactivatetest \
        selpolltest threadsignaltest writecaptest valgrindtest
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/testprogs
    install -m 0755 ${B}/testprogs/capturetest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/can_set_rfmon_test ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/filtertest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/findalldevstest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/findalldevstest-perf ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/opentest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/reactivatetest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/selpolltest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/threadsignaltest ${D}${PTEST_PATH}/testprogs/
    install -m 0755 ${B}/testprogs/writecaptest ${D}${PTEST_PATH}/testprogs/
    if [ -f ${B}/testprogs/valgrindtest ]; then
        install -m 0755 ${B}/testprogs/valgrindtest ${D}${PTEST_PATH}/testprogs/
    fi
}

RDEPENDS:${PN}-ptest += "bash"
INSANE_SKIP:${PN}-ptest += "ldflags"
