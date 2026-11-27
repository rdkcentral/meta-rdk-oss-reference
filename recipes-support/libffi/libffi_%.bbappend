inherit ptest

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://run-ptest"

RDEPENDS:${PN}-ptest += "bash ${PN}"

# Select representative test files covering core FFI functionality
LIBFFI_PTEST_SOURCES = " \
    return_sc.c return_uc.c return_sl.c return_ul.c \
    return_ll.c return_ll1.c \
    return_fl.c return_fl1.c return_dbl.c return_dbl1.c \
    float.c float1.c float2.c \
    strlen.c strlen2.c \
    many.c many2.c many_mixed.c \
    struct1.c struct2.c struct3.c struct4.c struct5.c \
    negint.c promotion.c offsets.c \
    va_1.c \
"

do_compile_ptest() {
    local test_src_dir="${S}/testsuite/libffi.call"
    local test_build_dir="${B}/ptest-bin"
    mkdir -p ${test_build_dir}

    for src in ${LIBFFI_PTEST_SOURCES}; do
        local test_name=$(basename $src .c)
        if [ -f "${test_src_dir}/${src}" ]; then
            ${CC} ${CFLAGS} ${LDFLAGS} \
                -I${B}/include -I${B} \
                -I${S}/testsuite/libffi.call \
                -o ${test_build_dir}/${test_name} \
                ${test_src_dir}/${src} \
                -L${B}/.libs -lffi -lm \
                || bbwarn "Failed to compile ${src}"
        fi
    done
}

do_install_ptest() {
    install -d ${D}${PTEST_PATH}/tests

    local test_build_dir="${B}/ptest-bin"
    for bin in ${test_build_dir}/*; do
        if [ -f "$bin" ] && [ -x "$bin" ]; then
            install -m 0755 "$bin" ${D}${PTEST_PATH}/tests/
        fi
    done
}
