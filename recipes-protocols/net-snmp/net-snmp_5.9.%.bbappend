#
# ============================================================================
# COMCAST C O N F I D E N T I A L AND PROPRIETARY
# ============================================================================
# This file and its contents are the intellectual property of Comcast.  It may
# not be used, copied, distributed or otherwise  disclosed in whole or in part
# without the express written permission of Comcast.
# ============================================================================
# Copyright (c) 2018 Comcast. All rights reserved.
# ============================================================================
#
FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"

SRC_URI += "file://support-multiple-local-certs.patch"
SRC_URI += "file://DELIA-40163.patch"
SRC_URI += "file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
SRC_URI += "file://remove_log_error.patch"
