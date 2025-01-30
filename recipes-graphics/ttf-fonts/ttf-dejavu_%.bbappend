do_install_append () {
    # Move the fonts to the proper directory for RDK
    install -d ${D}${datadir}/fonts/
    find ./ -name '*.tt[cf]' -exec install -m 0644 {} ${D}${datadir}/fonts/ \; 
    rm -rf ${D}${datadir}/fonts/truetype
}

FILES_${PN}-sans            = "${datadir}/fonts/DejaVuSans.ttf ${datadir}/fonts/DejaVuSans-*.ttf"
FILES_${PN}-sans-mono       = "${datadir}/fonts/DejaVuSansMono*.ttf"
FILES_${PN}-sans-condensed  = "${datadir}/fonts/DejaVuSansCondensed*.ttf"
FILES_${PN}-serif           = "${datadir}/fonts/DejaVuSerif.ttf ${datadir}/fonts/DejaVuSerif-*.ttf"
FILES_${PN}-serif-condensed = "${datadir}/fonts/DejaVuSerifCondensed*.ttf"
FILES_${PN}-mathtexgyre     = "${datadir}/fonts/DejaVuMathTeXGyre.ttf"
