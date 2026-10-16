FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://0001-jsonrpc-v1.3.0-ipv6.patch \
            file://0001-jsonrpc-v1.3.0-waitclientclose-no-hang.patch \
"
EXTRA_OECMAKE += " -DTCP_SOCKET_SERVER=YES -DTCP_SOCKET_CLIENT=YES "

do_install:append() {
          install -d ${D}${includedir}/jsonrpccpp
          install -d ${D}${includedir}/jsonrpccpp/server
          install -d ${D}${includedir}/jsonrpccpp/server/connectors
          install -d ${D}${includedir}/jsonrpccpp/client
          install -d ${D}${includedir}/jsonrpccpp/client/connectors
          install -m 0644 ${S}/src/jsonrpccpp/*.h ${D}${includedir}/jsonrpccpp
          install -m 0644 ${S}/src/jsonrpccpp/server/*.h ${D}${includedir}/jsonrpccpp/server
          install -m 0644 ${S}/src/jsonrpccpp/server/connectors/*.h ${D}${includedir}/jsonrpccpp/server/connectors
          install -m 0644 ${S}/src/jsonrpccpp/client/*.h ${D}${includedir}/jsonrpccpp/client
          install -m 0644 ${S}/src/jsonrpccpp/client/connectors/*.h ${D}${includedir}/jsonrpccpp/client/connectors
}
do_configure:prepend:wrynose() {
    sed -i 's/cmake_policy(SET CMP0042 OLD)/cmake_policy(SET CMP0042 NEW)/g' \
        ${S}/CMakeLists.txt
}
do_install:append:wrynose() {
    rm -rf ${D}${libdir}/libjson-rpc-cpp/cmake
}
ERROR_QA:remove = "patch-status"
INSANE_SKIP += "files-invalid"
INSANE_SKIP:${PN} += "installed-vs-shipped"
