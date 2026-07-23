# OE6 wrynose: [build-deps] glibc-gconv-*/locale-base-* are runtime-only for libxml2-ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
