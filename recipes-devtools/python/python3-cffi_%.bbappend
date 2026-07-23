# python3-cffi-ptest RDEPENDS on gcc-symlinks/g++-symlinks (GPL-3.0-only).
# Excluded by INCOMPATIBLE_LICENSE in wrynose — remove from ptest deps.
RDEPENDS:${PN}-ptest:remove:wrynose = "gcc-symlinks g++-symlinks"
