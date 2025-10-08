RDEPENDS:${PN} += "libgettextlib libgettextsrc"

PROVIDES:libgettextlib = "libgettextlib"
PROVIDES:libgettextsrc = "libgettextsrc"

PRIVATE_LIBS:libgettextlib = "libgettextlib"
PRIVATE_LIBS:libgettextsrc = "libgettextsrc"

FILES:libgettextlib = "${libdir}/**/libgettextlib*.so*"
FILES:libgettextsrc = "${libdir}/**/libgettextsrc*.so*"

INSANE_SKIP:${PN} += "file-rdeps"
