PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras =  "\
                        ${libdir}/libgrpc++_alts.so* \
                        ${libdir}/libgrpc++_error_details.so* \
                        ${libdir}/libgrpc++_reflection.so* \
"
