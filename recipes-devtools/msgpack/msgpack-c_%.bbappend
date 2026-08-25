# msgpack-c v4 renamed its C library from libmsgpackc to libmsgpack-c. Roughly 20
# RDK components still ask for the old name -- some in their own recipe LDFLAGS,
# most in upstream Makefile.am files -- and fail at link with:
#   ld: cannot find -lmsgpackc: No such file or directory
# (seen in ccsp-lm-lite, remotedebugger, ccsp-misc, cpeabs, wrp-c, parodus,
# webcfg, rfc-agent, ccsp-p-and-m, parodus2ccsp, ccsp-moca, ccsp-dhcp-mgr,
# rdktelcovoicemanager, ccsp-adv-security, ccsp-xdns, test-and-diagnostic, ...)
#
# Provide one link-time compatibility symlink here instead of patching every
# consumer. Only the development .so symlink is required: -lmsgpackc is resolved
# at link time, while the SONAME recorded in the produced binaries is already
# libmsgpack-c.so.2 -- so nothing changes at runtime and no package needs it.
#
# wrynose only. kirkstone links against the old name against an older msgpack
# and must not be affected (cf. the existing in-tree idiom in ccsp-cr.bb and
# wrp-c_1.0.bb, which keep -lmsgpackc for non-wrynose).

do_install:append:wrynose() {
    if [ -e ${D}${libdir}/libmsgpack-c.so ]; then
        ln -sf libmsgpack-c.so ${D}${libdir}/libmsgpackc.so
    fi
    if [ -e ${D}${libdir}/libmsgpack-c.a ]; then
        ln -sf libmsgpack-c.a ${D}${libdir}/libmsgpackc.a
    fi
}

FILES:${PN}-dev:append:wrynose = " ${libdir}/libmsgpackc.so"
FILES:${PN}-staticdev:append:wrynose = " ${libdir}/libmsgpackc.a"
