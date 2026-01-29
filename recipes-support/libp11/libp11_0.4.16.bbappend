#Currently using legacy engine support; hence removing PKCS#11 provider-related files in rootfs
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://libp11-crash-fix.patch"
S = "${WORKDIR}/git"
do_install:append () {
    rm -rf ${D}${docdir}/${BPN}
    rm -rf ${D}/usr/lib/ossl-modules
    rm -f ${D}/usr/lib/ossl-modules/pkcs11prov.so
    rm -f ${D}/usr/lib/ossl-modules/libpkcs11.so
}
