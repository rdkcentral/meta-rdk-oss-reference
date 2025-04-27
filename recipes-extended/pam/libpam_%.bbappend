#To avoid copying coreutils binaries into /bin folder, which is overriding the busybox binaries.
RDEPENDS:${PN}-xtests:remove = "coreutils"
RDEPENDS:${PN}-xtests:append = " bash"

