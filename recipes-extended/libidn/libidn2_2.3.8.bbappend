LICENSE = "(GPL-2.0-or-later | LGPL-3.0-only) & Unicode-DFS-2016"

PACKAGES:remove = "${PN}-bin"

do_install:append() {
	rm -f ${D}${bindir}/idn2
	rmdir ${D}${bindir}
}