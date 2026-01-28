PACKAGECONFIG:remove = "libunwind"
DEPENDS:remove = "${MLPREFIX}binutils binutils"
do_install:append() {
       rm -f ${D}/usr/bin/trace
}
