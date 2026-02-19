#
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://nlist_no_a_out_h.patch \
                   file://CVE-2019-20367_fix.patch \
                 "

