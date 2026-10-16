EXTRA_OECMAKE += " -DHTTP_SERVER=NO "
DEPENDS:remove = " libmicrohttpd "

DEPENDS:remove = " hiredis"
EXTRA_OECMAKE += " -DREDIS_SERVER=NO -DREDIS_CLIENT=NO"

do_install:append() {
    install -d ${D}${includedir}/jsonrpccpp
    cp -r ${S}/src/jsonrpccpp/* ${D}${includedir}/jsonrpccpp/
}
