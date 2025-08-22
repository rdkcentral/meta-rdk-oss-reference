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
FILESEXTRAPATHS_prepend := "${THISDIR}/${BP}:"

SRC_URI += "file://support-multiple-local-certs.patch"
SRC_URI += "file://0001-snmplib-snmp_api-Remove-the-request-on-the-session-w.patch"
SRC_URI += "file://0001-agentx-master-Return-when-NETSNMP_CALLBACK_OP_RESEND.patch"
SRC_URI += "file://DELIA-40163.patch"
SRC_URI += "file://0001-snmpd-Fix-a-buffer-overflow-triggered-by-processing-.patch"
SRC_URI += "file://0001-snmpd-Fix-a-memory-leak-in-handle_agentx_packet.patch"
SRC_URI += "file://0001-agent-mibgroup-agentx-Fix-double-free-of-delegated-c.patch"
SRC_URI_append_kirkstone = " file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
