CFLAGS:remove = "\${DEBUG_FLAGS}"
CXXFLAGS:remove = "\${DEBUG_FLAGS}"

EXTRA_OECONF:append = " --disable-libitm"
RUNTIMELIBITM:arm = ""

do_configure:prepend() {
    CFLAGS=$(printf '%s\n' "${CFLAGS}" | sed 's/\${DEBUG_FLAGS}//g')
    CXXFLAGS=$(printf '%s\n' "${CXXFLAGS}" | sed 's/\${DEBUG_FLAGS}//g')
    sed -i '/-ftls-model=initial-exec/d' ${S}/libitm/configure.tgt
}

do_configure:append() {
    find ${B} -path '*/libstdc++-v3/src/c++11/Makefile' -type f -exec \
        sed -i 's/$(LTCXXCOMPILE) -gno-as-loc-support -S/$(CXXCOMPILE) -gno-as-loc-support -S/' {} +
    find ${B} -path '*/libstdc++-v3/*/Makefile' -type f -exec \
        sed -i \
            -e 's/^glibcxx_lt_pic_flag = -prefer-pic$/glibcxx_lt_pic_flag = -fPIC/' \
            -e '/^LTCOMPILE =/,/^$/ s/--tag disable-shared //' \
            -e '/^LTCXXCOMPILE =/,/^$/ s/--tag disable-shared //' \
            -e '/^CXXLINK =/,/^$/ s/--tag disable-shared //' {} +
}

FILES:libstdc++ += "${libdir}/libstdc++fs.so.* ${libdir}/libstdc++exp.so.* ${libdir}/libsupc++.so.*"
FILES:libstdc++-dev += "${libdir}/libstdc++fs.so ${libdir}/libstdc++exp.so ${libdir}/libsupc++.so"