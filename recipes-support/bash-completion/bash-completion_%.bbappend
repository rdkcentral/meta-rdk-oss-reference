# OE6 wrynose: [build-deps] bash is runtime-only; not a build dep in standalone builds
INSANE_SKIP:${PN}:append:wrynose = " build-deps"
