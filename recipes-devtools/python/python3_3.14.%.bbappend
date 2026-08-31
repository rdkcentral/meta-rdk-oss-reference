# Disable gdbm for both target and native builds
PACKAGECONFIG:remove = "gdbm"
PACKAGECONFIG:remove:class-native = "gdbm"

# Remove the gdbm subpackage (which would expect _dbm.so)
PACKAGES:remove = "${PN}-gdbm"
FILES:${PN}-gdbm = ""
RDEPENDS:${PN}-gdbm = ""
