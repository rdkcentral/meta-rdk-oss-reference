FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI += "file://procps.pc \
            file://ignore_pkill_requests_with_empty_pattern.patch"


do_install_append() {
	install -d ${D}${libdir}/pkgconfig/
	install -m 0644 ${WORKDIR}/procps.pc ${D}${libdir}/pkgconfig/procps.pc
}
