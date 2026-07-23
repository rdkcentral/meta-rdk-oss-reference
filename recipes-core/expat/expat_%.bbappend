# OE6 wrynose: [build-deps]/[file-rdeps] bash is runtime-only for ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
