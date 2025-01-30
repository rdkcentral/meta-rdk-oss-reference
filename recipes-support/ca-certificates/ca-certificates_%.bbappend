FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://005_modify_CA_Bundle_path_kirkstone.patch"

SRC_URI:append:class-nativesdk = " file://0001-esdk-cert-path-issue_kirkstone.patch"

DEPENDS += "openssl-native"

PACKAGE_BEFORE_PN += "${PN}-trust-store"

PROVIDES:${PN}-trust-store += "virtual/ca-certificates-trust-store"
RPROVIDES:${PN}-trust-store += " virtual/ca-certificates-trust-store"

FILES:${PN}-trust-store += "${datadir}/ca-certificates/*"
FILES:${PN}-trust-store += "${sysconfdir}/*"
