#PROVIDES += " gdbm-compat"
#RPROVIDES:${PN} +=  " libgdbm_compat.so.4()(64bit)"

RDEPENDS:${PN} += "gdbm-compat"
RDEPENDS:python3-db += "gdbm-compat"

#PACKAGES += "libgdbm-compat"
FILES:libgdbm-compat = "${libdir}/libgdbm_compat.so.*"

#INSANE_SKIP:python3-db += "file-rdeps"
