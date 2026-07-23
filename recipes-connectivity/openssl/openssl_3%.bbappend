# OE6 wrynose: [build-deps] perl/bash/sed are runtime-only for openssl-ptest and openssl-misc
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
INSANE_SKIP:${PN}-misc:append:wrynose = " build-deps"
