FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://local.conf"

do_install_append() {
	install -d ${D}${sysconfdir}/fonts
	install -m 0644 ${WORKDIR}/local.conf ${D}${sysconfdir}/fonts
        rm ${D}${sysconfdir}/fonts/conf.d/README
        rm ${D}${datadir}/fontconfig/conf.avail/10-autohint.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-no-sub-pixel.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-bgr.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-rgb.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-vbgr.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-vrgb.conf
        rm ${D}${datadir}/fontconfig/conf.avail/10-unhinted.conf
        rm ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-default.conf
        rm ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-legacy.conf
        rm ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-light.conf
        rm ${D}${datadir}/fontconfig/conf.avail/25-unhint-nonlatin.conf
        rm ${D}${datadir}/fontconfig/conf.avail/65-khmer.conf
        rm ${D}${datadir}/fontconfig/conf.avail/70-no-bitmaps.conf
        rm ${D}${datadir}/fontconfig/conf.avail/70-yes-bitmaps.conf
    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'cobalt-plugin', 'true', 'false', d)}" = "true" ]
        then
        if [ "${@bb.utils.contains('DISTRO_FEATURES', 'libcobalt-rdm', 'true', 'false', d)}" = "true" ]
        then
            sed -i '0,/<dir>/!b;//a\    <dir>/media/apps/libcobalt/usr/share/content/data/fonts</dir>' ${D}${sysconfdir}/fonts/local.conf
        fi
    else
        sed -i '0,/<dir>/!b;//a\    <dir>/media/apps/notowoff2/usr/share/fonts</dir>' ${D}${sysconfdir}/fonts/local.conf
    fi
}

FILES_${PN}_remove += "${sysconfdir}/fonts/conf.d/README ${datadir}/fontconfig/conf.avail/10-autohint.conf ${datadir}/fontconfig/conf.avail/10-no-sub-pixel.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-bgr.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-rgb.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-vbgr.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-vrgb.conf ${datadir}/fontconfig/conf.avail/10-unhinted.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-default.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-legacy.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-light.conf ${datadir}/fontconfig/conf.avail/25-unhint-nonlatin.conf ${datadir}/fontconfig/conf.avail/65-khmer.conf ${datadir}/fontconfig/conf.avail/70-no-bitmaps.conf ${datadir}/fontconfig/conf.avail/70-yes-bitmaps.conf"

