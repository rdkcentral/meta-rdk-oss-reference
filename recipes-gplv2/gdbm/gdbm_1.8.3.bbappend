inherit autotools

DEPENDS += "libtool-native autoconf-native automake-native"

CFLAGS:append:class-native = " -fPIC"

do_configure:prepend() {
    rm -f ${S}/libtool
    rm -f ${S}/ltmain.sh
    rm -f ${S}/aclocal.m4

    export PATH=${RECIPE_SYSROOT_NATIVE}/usr/bin:$PATH

    cd ${S}

    if [ -f ${S}/configure.in ] && [ ! -f ${S}/configure.ac ]; then
        cp -vf ${S}/configure.in ${S}/configure.ac
    fi

    gnu-configize

    aclocal
    libtoolize --force --copy
    autoconf

    cd ${B}
    oe_runconf
}
CFLAGS:append = " -Wno-error=incompatible-pointer-types"
