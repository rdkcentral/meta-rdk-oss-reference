# OE6 migration (wrynose): per-package INSANE_SKIP via perl_%.bbappend is masked
# in meta-rdk-oss-reference/conf/layer.conf (BBMASK). Use this version-specific
# bbappend which is NOT masked.

# perl-ptest RDEPENDS on sed and procps-ps as runtime test utilities. These are
# not build-time dependencies. Per-package INSANE_SKIP:perl-ptest is unreliable
# because perl-ptest is not in OVERRIDES at do_package_qa time. Use the global
# INSANE_SKIP (which insane.bbclass also checks) to skip the [build-deps] check
# for all perl packages.
INSANE_SKIP:append:wrynose = " build-deps"

# GCC 15 / glibc 2.42: ndbm function prototypes changed to empty () parameter
# lists which in C23 means zero arguments. NDBM_File.xs passes arguments.
# -Ui_ndbm disables ndbm.h; -Ui_gdbmndbm disables gdbm's ndbm compat header.
PACKAGECONFIG_CONFARGS:append:wrynose = " -Ui_ndbm -Ui_gdbmndbm"
