# provided by libnsl2
do_install:append:class-nativesdk() {
    rm -f ${D}${includedir}/rpcsvc/yppasswd.*
}