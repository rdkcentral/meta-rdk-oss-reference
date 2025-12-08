do_install() {
    install -d ${D}/usr/www2/cmn/js/lib
    install -m 0644 ${S}/jquery-3.7.1.js ${D}/usr/www2/cmn/js/lib
    install -m 0644 ${S}/jquery-3.7.1.min.js ${D}/usr/www2/cmn/js/lib
    install -m 0644 ${S}/jquery-3.7.1.min.map ${D}/usr/www2/cmn/js/lib
}

FILES:${PN} = "/usr/www2/cmn/js/lib"
