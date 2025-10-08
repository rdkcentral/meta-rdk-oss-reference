#FILES:${PN}-compat = "${libdir}/libgdbm_compat.so.*"
#RPROVIDES:${PN}-compat += "libgdbm_compat"

INSANE_SKIP:perl-module-ndbm-file += "file-rdeps"
