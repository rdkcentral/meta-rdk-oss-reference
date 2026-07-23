# OE6 wrynose: [build-deps] locale-base-de-de and perl are runtime-only for nlohmann-json-ptest
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
