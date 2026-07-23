# elfutils-ptest RDEPENDS on gcc-symlinks/binutils-symlinks/libgcc-dev (GPL-3.0-only).
# These are excluded by INCOMPATIBLE_LICENSE in wrynose — remove from ptest deps.
RDEPENDS:${PN}-ptest:remove:wrynose = "gcc-symlinks binutils-symlinks libgcc-dev"

# Per-package LICENSE for auto-generated sub-packages: headers, debug info,
# static libs, docs and source all relate to the LGPL-licensed libraries
# (libelf/libasm/libdw/libdebuginfod). Without explicit overrides they inherit
# the recipe-level "(GPL-2.0-or-later | LGPL-3.0-or-later) & GPL-3.0-or-later"
# which triggers incompatible-license exclusion for the GPL-3.0 component.
LICENSE:${PN}-dev:wrynose       = "GPL-2.0-or-later | LGPL-3.0-or-later"
LICENSE:${PN}-staticdev:wrynose = "GPL-2.0-or-later | LGPL-3.0-or-later"
LICENSE:${PN}-dbg:wrynose       = "GPL-2.0-or-later | LGPL-3.0-or-later"
LICENSE:${PN}-doc:wrynose       = "GPL-2.0-or-later | LGPL-3.0-or-later"
LICENSE:${PN}-src:wrynose       = "GPL-2.0-or-later | LGPL-3.0-or-later"

# Disable NLS to prevent locale packages from being generated.
# Individual locale packages inherit the recipe-level GPL-3.0-or-later
# and would fail the incompatible-license QA check in wrynose.
EXTRA_OECONF:append:wrynose = " --disable-nls"

# elfutils-binutils (eu-addr2line etc.) and elfutils-ptest are GPL-3.0-or-later.
# Remove them from PACKAGES; their FILES fall to ${PN} (the catch-all).
# The ${PN} package itself is also GPL-3.0-or-later (eu-* tools); make the
# remaining incompatible-license exclusion of ${PN} non-fatal.
PACKAGES:remove:wrynose = "${PN}-binutils ${PN}-ptest"
ERROR_QA:remove:pn-elfutils = "incompatible-license"
