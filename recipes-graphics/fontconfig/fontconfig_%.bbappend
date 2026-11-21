FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

LIC_FILES_CHKSUM = "file://COPYING;md5=00252fd272bf2e722925613ad74cb6c7 \
                    file://src/fcfreetype.c;endline=45;md5=e6867d083e760847d1d9ef6428b5e006 \
                    file://src/fccache.c;beginline=1712;endline=1727;md5=fb55e8b29666773a4e9726fac4a38e35"


SRC_URI += "file://local.conf \
            file://add-mtime-ignore-check.patch \
        "
SRC_URI:remove = "${@'file://add-mtime-ignore-check.patch' if d.getVar('PV') == '2.17.1' else ''}"
SRC_URI:append = "${@' file://add-mtime-ignore-check-2.17.1.patch' if d.getVar('PV') == '2.17.1' else ''}"

do_install:append() {
	install -d ${D}${sysconfdir}/fonts
	install -m 0644 ${UNPACKDIR}/local.conf ${D}${sysconfdir}/fonts
        rm -f ${D}${sysconfdir}/fonts/conf.d/README
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-autohint.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-no-sub-pixel.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-bgr.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-rgb.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-vbgr.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-sub-pixel-vrgb.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/10-unhinted.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-default.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-legacy.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/11-lcdfilter-light.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/25-unhint-nonlatin.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/65-khmer.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/70-no-bitmaps.conf
        rm -f ${D}${datadir}/fontconfig/conf.avail/70-yes-bitmaps.conf
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

FILES:${PN}:remove = "${sysconfdir}/fonts/conf.d/README ${datadir}/fontconfig/conf.avail/10-autohint.conf ${datadir}/fontconfig/conf.avail/10-no-sub-pixel.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-bgr.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-rgb.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-vbgr.conf ${datadir}/fontconfig/conf.avail/10-sub-pixel-vrgb.conf ${datadir}/fontconfig/conf.avail/10-unhinted.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-default.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-legacy.conf ${datadir}/fontconfig/conf.avail/11-lcdfilter-light.conf ${datadir}/fontconfig/conf.avail/25-unhint-nonlatin.conf ${datadir}/fontconfig/conf.avail/65-khmer.conf ${datadir}/fontconfig/conf.avail/70-no-bitmaps.conf ${datadir}/fontconfig/conf.avail/70-yes-bitmaps.conf"

