# gdbm 1.8.3 (pinned in this layer) is too old for Python 3.14 _dbm/_gdbm modules.
# Removing gdbm from PACKAGECONFIG causes Setup.local to list _gdbm/_dbm in *disabled*
# so Python does not attempt to build them and do_install does not fail.
PACKAGECONFIG:remove:wrynose = "gdbm"

# python3-tests/python3-ptest RDEPENDS on host tools (bash, gcc, coreutils, etc.)
# at runtime only — suppress package-level build-deps QA check.
INSANE_SKIP:${PN}-tests:append:wrynose = " build-deps"
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"

# python3-ptest RDEPENDS on gcc/gcc-symlinks/g++/binutils (GPL-3.0-only).
# These are excluded by INCOMPATIBLE_LICENSE in wrynose, which causes bitbake
# to mark python3 entirely unbuildable (via ptest sub-package).
# Remove GPL-3.0-only tools from ptest deps — they are not needed at runtime.
RDEPENDS:${PN}-ptest:remove:wrynose = "gcc gcc-symlinks g++ binutils"
