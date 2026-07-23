DEPENDS:remove = "libunistring"

# The library (lib/*.c, lib/idn2.h.in) is dual-licensed LGPL-3.0 OR GPL-2.0.
# Only src/idn2.c (the idn2 binary) is GPL-3.0-or-later.
# OE-core sets LICENSE:${PN} and LICENSE:${PN}-bin correctly but omits
# dev/staticdev/dbg/src/doc and the dynamic locale sub-packages, which
# then incorrectly inherit the recipe-level GPL-3.0-or-later.
# Fix: set the accurate LGPL/GPL-2.0 dual license on all non-binary packages.
LIB_LIC = "(GPL-2.0-or-later | LGPL-3.0-only) & Unicode-DFS-2016"
LICENSE:${PN}-dev      = "${LIB_LIC}"
LICENSE:${PN}-staticdev = "${LIB_LIC}"
LICENSE:${PN}-dbg      = "${LIB_LIC}"
LICENSE:${PN}-src      = "${LIB_LIC}"
LICENSE:${PN}-doc      = "${LIB_LIC}"

# Locale packages are created dynamically by package_do_split_locales, which
# runs before populate_packages (where the license check fires). Set their
# license here so the check sees the correct value.
python populate_packages:prepend() {
    pn = d.getVar('PN')
    lic = d.getVar('LIB_LIC')
    for pkg in (d.getVar('PACKAGES') or '').split():
        if pkg.startswith(pn + '-locale-'):
            d.setVar('LICENSE:' + pkg, lic)
}

# libidn2-bin is GPL-3.0-or-later (src/idn2.c); exclude it from packaging
# to avoid incompatible-license QA failure (the binary is not needed on target).
PACKAGES:remove = "${PN}-bin"
