BBCLASSEXTEND:append = " nativesdk"

PACKAGES =+ "${PN}-stackwalk ${PN}-binaries"
FILES:${PN}-stackwalk = "${bindir}/minidump_stackwalk"
FILES:${PN}-binaries = "${bindir}/*"
