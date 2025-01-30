do_install:append () {
    # Move the fonts to the proper directory for RDK
    install -d ${D}${datadir}/fonts/
    find ./ -name '*.tt[cf]' -exec install -m 0644 {} ${D}${datadir}/fonts/ \; 
    rm -rf ${D}${datadir}/fonts/truetype
}

FILES:${PN}-sans            = "${datadir}/fonts/DejaVuSans.ttf ${datadir}/fonts/DejaVuSans-*.ttf"
FILES:${PN}-sans-mono       = "${datadir}/fonts/DejaVuSansMono*.ttf"
FILES:${PN}-sans-condensed  = "${datadir}/fonts/DejaVuSansCondensed*.ttf"
FILES:${PN}-serif           = "${datadir}/fonts/DejaVuSerif.ttf ${datadir}/fonts/DejaVuSerif-*.ttf"
FILES:${PN}-serif-condensed = "${datadir}/fonts/DejaVuSerifCondensed*.ttf"
FILES:${PN}-mathtexgyre     = "${datadir}/fonts/DejaVuMathTeXGyre.ttf"
