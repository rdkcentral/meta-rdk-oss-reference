PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras = " \
   			${libdir}/bellagio/*.so \
    			${libdir}/omxloaders/*${SOLIBS} \
   			${libdir}/libomxil-bellagio.so* \
"

