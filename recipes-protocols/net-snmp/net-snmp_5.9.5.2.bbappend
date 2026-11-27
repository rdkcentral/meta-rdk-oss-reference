FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"

SRC_URI:remove = "file://support-multiple-local-certs.patch file://DELIA-40163.patch file://remove_log_error.patch"
SRC_URI += "file://support-multiple-local-certs_wrynose.patch"
SRC_URI += "file://DELIA-40163_wrynose.patch"
