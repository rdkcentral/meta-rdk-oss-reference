# python3-psutil-tests RDEPENDS on gcc/gcc-symlinks/binutils/libstdc++-dev (GPL-3.0-only).
# Excluded by INCOMPATIBLE_LICENSE in wrynose — remove from tests deps.
RDEPENDS:${PN}-tests:remove:wrynose = "gcc gcc-symlinks binutils libstdc++-dev"
