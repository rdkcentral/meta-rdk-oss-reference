# For the native variant (used as build-time tool by opensync), clear all runtime
# dependencies — these packages are not available or needed in the native context.
RDEPENDS:${PN}:class-native = ""
RDEPENDS:${PN}-switch:class-native = ""
RDEPENDS:${PN}-testcontroller:class-native = ""
RDEPENDS:${PN}-pki:class-native = ""
RDEPENDS:${PN}-brcompat:class-native = ""
