SUMMARY = "OpenSSL 3.x provider to access Hardware and Software Tokens using PKCS#11"
DESCRIPTION = "This is an OpenSSL 3.x provider to access Hardware and Software Tokens \
using the PKCS#11 Cryptographic Token Interface."
HOMEPAGE = "https://github.com/openssl-projects/pkcs11-provider"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=b53b787444a60266932bd270d1cf2d45"

BBCLASSEXTEND = "native"

PV = "1.3.0"
PR = "r0"

# Tag v1.3.0
SRCREV = "b55b94344af87a058fd84d6e15390760a5585b1d"

SRC_URI = "git://github.com/openssl-projects/pkcs11-provider.git;protocol=https;branch=main"

SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'hrot_pkcs11_provider', ' file://pkcs11_provider_openssl_3.0.5_support.patch ', ' ', d)}"

S = "${WORKDIR}/git"

DEPENDS = "openssl p11-kit"

inherit meson pkgconfig



FILES_${PN} += "${libdir}/ossl-modules/*"

