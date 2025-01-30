
do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime', 'true','false',d)}; then
        # remove the symbolic link to localtime so we can bind mount later
        install -d ${D}${sysconfdir}/update
        mv ${D}${sysconfdir}/localtime ${D}${sysconfdir}/update/localtime
        ln -s /opt/persistent/localtime ${D}${sysconfdir}/localtime
    fi
}

FILES:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime' , ' ${sysconfdir}/update/*, '', d)}"
FILES:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime' , ' ${sysconfdir}/localtime, '', d)}"

#RDK-41715
RDEPENDS:${PN}:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'enable-tzdata-posix', '', ' tzdata-posix ', d)}"
RDEPENDS:${PN}:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'enable-tzdata-right', '', ' tzdata-right ', d)}"
