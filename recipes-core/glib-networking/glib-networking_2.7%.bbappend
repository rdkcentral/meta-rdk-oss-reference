FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://relax_read_error_handling.patch \
    file://force_tls1_2.patch \
    file://0001-XRE-14265-request-client-cert-support.patch \
"

# 0001-XRE-14265-request-client-cert-support.patch passes an incompatible pointer
# type to a GIO callback slot. Suppress the error introduced by gcc-15.
CFLAGS:append = " -Wno-incompatible-pointer-types"

PROVIDES += "glib-openssl"
RPROVIDES:${PN} += "glib-openssl"
