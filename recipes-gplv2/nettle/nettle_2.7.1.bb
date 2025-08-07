require nettle.inc

LICENSE = "LGPL-2.1-or-later & GPL-2.0-only"
LICENSE:${PN} = "LGPL-2.1-or-later"

LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=2d5025d4aa3495befef8f17206a5b0a1 \
                    file://serpent-decrypt.c;beginline=53;endline=67;md5=bcfd4745d53ca57f82907089898e390d \
                    file://serpent-set-key.c;beginline=56;endline=70;md5=bcfd4745d53ca57f82907089898e390d"

SRC_URI[md5sum] = "003d5147911317931dd453520eb234a5"
SRC_URI[sha256sum] = "bc71ebd43435537d767799e414fce88e521b7278d48c860651216e1fc6555b40"

SRC_URI += "\
            file://CVE-2015-8803_8805.patch \
            file://CVE-2015-8804.patch \
            file://check-header-files-of-openssl-only-if-enable_.patch \
            "

DISABLE_STATIC = ""

PACKAGES_DYNAMIC += "^${PN}-file-.*"
 
python populate_packages:prepend() {
    import os
    bindir = d.getVar("bindir")
    dvar = d.getVar("PKGD")
    do_split_packages( d, root=os.path.join(dvar, bindir), file_regex=r'^(nettle-hash|sexp-conv|pkcs1-conv|nettle-lfib-stream)$', output_pattern='${PN}-file-%s', description='file %s from ${PN}', prepend=True )
}
