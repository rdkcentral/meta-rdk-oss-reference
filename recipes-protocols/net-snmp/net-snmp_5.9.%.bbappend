FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"

SRC_URI += "file://support-multiple-local-certs.patch"
SRC_URI += "file://DELIA-40163.patch"
SRC_URI += "file://0001-libsnmp-Fix-the-build-against-OpenSSL-3.0.patch"
SRC_URI += "file://remove_log_error.patch"

do_compile:prepend() {
    sed -i 's|#define UNAMEPROG.*|#define UNAMEPROG "/usr/bin/unames"|' \
        ${B}/include/net-snmp/net-snmp-config-64.h || true

    sed -i 's|#define NETSNMP_CONFIGURE_OPTIONS.*|#define NETSNMP_CONFIGURE_OPTIONS ""|' \
        ${B}/include/net-snmp/net-snmp-config-64.h || true
}
do_install:append() {
    sed -i \
      -e 's|#define UNAMEPROG.*|#define UNAMEPROG "/usr/bin/uname"|' \
      -e 's|#define NETSNMP_CONFIGURE_OPTIONS.*|#define NETSNMP_CONFIGURE_OPTIONS ""|' \
      ${D}${includedir}/net-snmp/net-snmp-config-64.h
}

