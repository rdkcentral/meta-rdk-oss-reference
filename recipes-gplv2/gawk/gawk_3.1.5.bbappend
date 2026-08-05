#Add fix for fawk segmentation failure
SRC_URI:append = " file://gawk-3.1.5-segfault_fix.patch "

SRC_URI += "file://run-ptest"

inherit ptest

do_install_ptest() {
    mkdir -p ${D}${PTEST_PATH}/test
    for i in `grep -vE "@|^$|#|Gt-dummy" ${S}/test/Maketests |awk -F: '{print $1}'` Maketests; \
        do cp ${S}/test/$i* ${D}${PTEST_PATH}/test; \
    done
}

do_configure:append:wrynose() {
    sed -i '/extern double atof()/d' ${S}/missing_d/strtod.c

    sed -i \
        's|extern double gawk_strtod();|extern double gawk_strtod(const char *, const char **);|' \
        ${S}/awk.h

    sed -i '/register const char \*s;/d' ${S}/missing_d/strtod.c
    sed -i '/register const char \*\*ptr;/d' ${S}/missing_d/strtod.c

    sed -i \
        's|^gawk_strtod(s, ptr)$|gawk_strtod(const char *s, const char **ptr)|' \
        ${S}/missing_d/strtod.c

    sed -i '/extern double strtod()/d' ${S}/node.c
}
CFLAGS:append:wrynose = " -Wno-error=incompatible-pointer-types"
