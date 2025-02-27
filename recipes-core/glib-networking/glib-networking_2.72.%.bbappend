FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://relax_read_error_handling.patch \
    file://force_tls1_2.patch \
    file://0001-Add-support-for-PKCS-12-encrypted-files.patch \
    file://0001-XRE-14265-request-client-cert-support.patch \
"

PROVIDES += "glib-openssl"
RPROVIDES:${PN} += "glib-openssl"
