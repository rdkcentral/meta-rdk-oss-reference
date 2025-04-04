PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = "\
                        ${libdir}/libxmlsec1-gcrypt.so* \
                        ${libdir}/libxmlsec1-gnutls.so* \
"
