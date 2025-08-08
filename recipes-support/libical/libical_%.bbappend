PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras =  "\
                        ${libdir}/libical_cxx.so* \
                        ${libdir}/libicalss.so* \
                        ${libdir}/libicalss_cxx.so* \
                        ${libdir}/libical-glib.so* \
"
