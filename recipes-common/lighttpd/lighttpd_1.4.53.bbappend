FILESEXTRAPATHS_prepend := "${THISDIR}/lighttpd-1.4.53:"

SRC_URI_append = " file://bind_lighttpd-1.4.53.patch"
SRC_URI_append = " file://lighttpd-md4-compilation-error-fix.patch"
SRC_URI_append = " file://monotonic-time.patch"

CFLAGS_append_broadband = " -DSO_BINDTODEVICE"

SYSTEMD_SERVICE_${PN}_broadband = ""
INITSCRIPT_NAME_broadband = ""
INITSCRIPT_PARAMS_broadband = ""

FILES_${PN} += "${systemd_unitdir}/system/lighttpd.service"

RDEPENDS_${PN} += " \
    lighttpd-module-auth \
    lighttpd-module-authn-file \
    lighttpd-module-openssl \
"
RDEPENDS_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'offline_apps', 'lighttpd-module-alias', '', d)}"
# From meta-rdk-comcast/recipes-common/lighttpd/lighttpd_1.4.53.bbappend
FILESEXTRAPATHS_prepend:="${THISDIR}/${PN}:"

SRC_URI_append = " file://lighttpd.conf"

SRC_URI_append_broadband += " file://lighttpd_jst.conf_broadband "
SRC_URI_append_broadband += " file://lighttpd_php.conf_broadband "
SRC_URI_append = " file://CVE-2019-11072.patch "

DEPENDS_append = " zlib openssl"
EXTRA_OECONF_append = " --without-bzip2 --without-mysql --with-zlib --with-openssl"

SYSTEMD_SERVICE_${PN}_broadband = ""
INITSCRIPT_NAME_broadband = ""
INITSCRIPT_PARAMS_broadband = ""

RDEPENDS_${PN} += "\
                lighttpd-module-alias \
                lighttpd-module-proxy \
                lighttpd-module-fastcgi \
"

do_install_append() {
     install -d ${D}${sysconfdir}/lighttpd
	 install -m 0644 ${WORKDIR}/lighttpd.conf ${D}${sysconfdir}/lighttpd
     #mod_alias is already part of conf, we can add the two entries to the end of conf file 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'offline_apps', 'true', 'false', d)}; then
        #Remove the generic version added
        rm -f ${D}${sysconfdir}/lighttpd.d/offline_apps.conf
        cat ${WORKDIR}/offline_apps.conf >>${D}${sysconfdir}/lighttpd/lighttpd.conf
     fi
}

do_install_append_broadband() {
    install -d ${D}/var
    if ${@bb.utils.contains('DISTRO_FEATURES', 'webui_php', 'true', 'false', d)}; then
    	install ${WORKDIR}/lighttpd_php.conf_broadband ${D}${sysconfdir}/lighttpd.conf
    fi
    if ${@bb.utils.contains('DISTRO_FEATURES', 'webui_jst', 'true', 'false', d)}; then
	if ${@bb.utils.contains('DISTRO_FEATURES', 'bci', 'true', 'false', d)}; then
        	install ${WORKDIR}/lighttpd_php.conf_broadband ${D}${sysconfdir}/lighttpd.conf
	else
    		install ${WORKDIR}/lighttpd_jst.conf_broadband ${D}${sysconfdir}/lighttpd.conf
	fi
    fi
    rm -r ${D}${sysconfdir}/lighttpd
}

FILES_${PN} += "${sysconfdir}/lighttpd/lighttpd.conf"
FILES_${PN}_remove_broadband += "${sysconfdir}/lighttpd/lighttpd.conf"
# From meta-rdk-comcast-video/recipes-common/lighttpd/lighttpd_1.4.53.bbappend
FILESEXTRAPATHS_prepend:="${THISDIR}/${PN}:"
SRC_URI_append = " file://CVE-2022-22707_fix.patch "
