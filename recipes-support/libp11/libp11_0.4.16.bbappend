#Currently using legacy engine support; hence removing PKCS#11 provider-related files in rootfs
SRCREV = "545a32314d5c2f8a3b1dfcfc92521bd0dce5c71b"
S = "${WORKDIR}/git"
do_install:append () {
    rm -rf ${D}${docdir}/${BPN}
    rm -rf ${D}/usr/lib/ossl-modules
    rm -f ${D}/usr/lib/ossl-modules/pkcs11prov.so
    rm -f ${D}/usr/lib/ossl-modules/libpkcs11.so
}
