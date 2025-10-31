
EXTRA_OECONF:append:class-target = " --disable-testio-debug --disable-debugfs --disable-imager \
                --disable-tls --disable-uuidd \
                 --without-libiconv-prefix --without-libintl-prefix \
                "
EXTRA_OECONF:remove:class-target = "${@bb.utils.contains('DISTRO_FEATURES', 'storage_emmc', '--disable-debugfs', '',d)}"

EXTRA_OECONF:append:broadband:class-target = " --disable-resizer "

###Added install:append task to move e2initrd_helper file from libdir to bindir as per FHS compliance#######

do_install:append(){
        install -d ${D}${bindir}
        mv ${D}${libdir}/e2initrd_helper ${D}${bindir}
}
