
do_install_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime', 'true','false',d)}; then
        # remove the symbolic link to localtime so we can bind mount later
        install -d ${D}${sysconfdir}/update
        mv ${D}${sysconfdir}/localtime ${D}${sysconfdir}/update/localtime
        ln -s /opt/persistent/localtime ${D}${sysconfdir}/localtime
    fi
}

FILES_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime' , ' ${sysconfdir}/update/*, '', d)}"
FILES_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'link_localtime' , ' ${sysconfdir}/localtime, '', d)}"

#RDK-41715
RDEPENDS_${PN}_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'enable-tzdata-posix', '', ' tzdata-posix ', d)}"
RDEPENDS_${PN}_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'enable-tzdata-right', '', ' tzdata-right ', d)}"
