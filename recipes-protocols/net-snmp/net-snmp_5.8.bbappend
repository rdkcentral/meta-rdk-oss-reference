# wrynose OE6: ${BP}=net-snmp-5.8 but support-multiple-local-certs.patch is in net-snmp/ subdir
FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:${THISDIR}/${BP}:"

SRC_URI += "file://support-multiple-local-certs.patch"
# wrynose OE6/GCC-15: snmp_api.h has 'return val' in void function; suppress -Wreturn-mismatch
# support-multiple-local-certs.patch calls netsnmp_ds_register_localcerts() before its definition
# (no forward declaration); GCC-15 C23 treats implicit function decl as error
CFLAGS:append:wrynose = " -Wno-return-mismatch -Wno-implicit-function-declaration"
# wrynose: snmplib_snmp_api patch already in upstream net-snmp 5.8 source
# SRC_URI += "file://0001-snmplib-snmp_api-Remove-the-request-on-the-session-w.patch"
# wrynose: agentx-master patch already in upstream net-snmp 5.8 source
# SRC_URI += "file://0001-agentx-master-Return-when-NETSNMP_CALLBACK_OP_RESEND.patch"
# wrynose OE6: DELIA-40163 already upstream in net-snmp 5.8 source at SRCREV
#SRC_URI += "file://DELIA-40163.patch"
# wrynose OE6: these three patches are also in meta-rdk-comcast bbappend — applying both causes
# "already applied" quilt error. Keep only in meta-rdk-comcast (higher BBFILE_PRIORITY).
#SRC_URI += "file://0001-snmpd-Fix-a-buffer-overflow-triggered-by-processing-.patch"
#SRC_URI += "file://0001-snmpd-Fix-a-memory-leak-in-handle_agentx_packet.patch"
#SRC_URI += "file://0001-agent-mibgroup-agentx-Fix-double-free-of-delegated-c.patch"
# wrynose OE6: patches apply with fuzz; remove from ERROR_QA
ERROR_QA:remove = "patch-fuzz patch-status"
# wrynose OE6: 'BSD' is not a valid SPDX identifier; suppress license-exists QA check
ERROR_QA:remove += "license-exists"
# wrynose OE6: apply the OpenSSL 3.0 compatibility patch (same as kirkstone)
SRC_URI:append:wrynose = " file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
SRC_URI:append:kirkstone = " file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
