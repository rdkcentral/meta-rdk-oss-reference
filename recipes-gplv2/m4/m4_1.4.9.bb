require m4-${PV}.inc

BBCLASSEXTEND = "nativesdk"
do_configure:prepend:wrynose() {
    # Remove obsolete popen declaration to fix modern toolchain build error
    sed -i '/extern FILE \*popen ();/d' ${S}/src/builtin.c
}
