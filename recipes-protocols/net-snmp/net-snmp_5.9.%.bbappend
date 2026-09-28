FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"

SRC_URI += "file://support-multiple-local-certs.patch"
SRC_URI += "file://DELIA-40163.patch"
SRC_URI += "file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
SRC_URI += "file://remove_log_error.patch"
