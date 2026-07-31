FILESEXTRAPATHS:prepend := "${THISDIR}/libunwind:"
require libunwind_1.7.0.inc

SRC_URI = "git://github.com/libunwind/libunwind.git;protocol=https;branch=master \
          "
SRCREV = "e6d3ba30d79ca5a8f1206b81740404224fa745eb"


SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://core.patch','', d)}"
SRC_URI += "file://0001-Try-loading-debug-info-from-.debug-dir-first.patch"

S = "${WORKDIR}/git"

#SRC_URI[sha256sum] = "4a6aec666991fb45d0889c44aede8ad6eb108071c3554fcdff671f9c94794976"
PROVIDES = "${MLPREFIX}${PN}"

#inherit cmake
#EXTRA_OECONF:append:libc-musl = " --disable-documentation --disable-tests --enable-static"
EXTRA_OECONF += "--enable-debug"
# http://errors.yoctoproject.org/Errors/Details/20487/
ARM_INSTRUCTION_SET:armv4 = "arm"
ARM_INSTRUCTION_SET:armv5 = "arm"

COMPATIBLE_HOST:riscv32 = "null"
LDFLAGS += "-Wl,-z,relro,-z,now ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', ' -fuse-ld=bfd ', '', d)}"

SECURITY_LDFLAGS:append:libc-musl = " -lssp_nonshared"
CACHED_CONFIGUREVARS:append:libc-musl = " LDFLAGS='${LDFLAGS} -lucontext'"
