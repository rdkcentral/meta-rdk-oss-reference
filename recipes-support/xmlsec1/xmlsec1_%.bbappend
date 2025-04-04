PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = "\
                        ${libdir}/libxmlsec1-gcrypt.so* \
                        ${libdir}/libxmlsec1-gnutls.so* \
"
#Recipe already has a skip of PN to dev-so for the package_qa issue since the .so are symlinks.
INSANE_SKIP:${PN}-extras = "dev-so"
