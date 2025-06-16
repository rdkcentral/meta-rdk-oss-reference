PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = " \
    ${bindir}/zstd \
    ${bindir}/pzstd \
"
FILES:${PN}:remove = "\
    ${bindir}/zstd \
    ${bindir}/pzstd \
"
