DEPENDS:remove = "libunistring"

LIB_LIC = "(GPL-2.0-or-later | LGPL-3.0-only) & Unicode-DFS-2016"
LICENSE:${PN}-dev = "${LIB_LIC}"
LICENSE:${PN}-staticdev = "${LIB_LIC}"
LICENSE:${PN}-dbg = "${LIB_LIC}"
LICENSE:${PN}-src = "${LIB_LIC}"
LICENSE:${PN}-doc = "${LIB_LIC}"

python populate_packages:prepend() {
    pn = d.getVar('PN')
    lic = d.getVar('LIB_LIC')
    for pkg in (d.getVar('PACKAGES') or '').split():
        if pkg.startswith(pn + '-locale-'):
            d.setVar('LICENSE:' + pkg, lic)
}

PACKAGES:remove = "${PN}-bin"
