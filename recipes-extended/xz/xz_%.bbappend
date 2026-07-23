# OE6 wrynose: [build-deps]/[file-rdeps] bash and file are runtime-only for xz-ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps file-rdeps"
