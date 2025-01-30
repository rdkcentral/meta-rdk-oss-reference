FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_dunfell = " file://005_modify_CA_Bundle_path_3.1.15.patch"
SRC_URI_append_morty = " file://005_modify_CA_Bundle_path.patch"
SRC_URI_append_kirkstone = " file://005_modify_CA_Bundle_path_kirkstone.patch"

SRC_URI_append_class-nativesdk_dunfell += " \
            ${@bb.utils.contains('DISTRO_FEATURES', 'yocto-3.1.15', 'file://2021-esdk-cert-path-issue.patch', 'file://0001-esdk-cert-path-issue.patch', d)} \
                                  "
SRC_URI_append_class-nativesdk_kirkstone = " file://0001-esdk-cert-path-issue_kirkstone.patch"
SRC_URI_append_class-nativesdk_morty = " file://0001-esdk-cert-path-issue.patch"

DEPENDS += "openssl-native"

PACKAGE_BEFORE_PN += "${PN}-trust-store"

PROVIDES_${PN}-trust-store += "virtual/ca-certificates-trust-store"
RPROVIDES_${PN}-trust-store += " virtual/ca-certificates-trust-store"

FILES_${PN}-trust-store += "${datadir}/ca-certificates/*"
FILES_${PN}-trust-store += "${sysconfdir}/*"
