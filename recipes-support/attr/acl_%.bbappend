# OE6 wrynose: [build-deps]/[file-rdeps] perl/coreutils are runtime-only for ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
