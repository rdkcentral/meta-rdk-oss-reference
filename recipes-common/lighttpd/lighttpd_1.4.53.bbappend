FILESEXTRAPATHS:prepend := "${THISDIR}/lighttpd-1.4.53:"

SRC_URI:append = " file://bind_lighttpd-1.4.53.patch"
SRC_URI:append = " file://lighttpd-md4-compilation-error-fix.patch"
SRC_URI:append = " file://monotonic-time.patch"

CFLAGS:append:broadband = " -DSO_BINDTODEVICE"

SYSTEMD_SERVICE:${PN}_broadband = ""
INITSCRIPT_NAME:broadband = ""
INITSCRIPT_PARAMS:broadband = ""

FILES:${PN} += "${systemd_unitdir}/system/lighttpd.service"

RDEPENDS:${PN} += " \
    lighttpd-module-auth \
    lighttpd-module-authn-file \
    lighttpd-module-openssl \
"
RDEPENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'offline_apps', 'lighttpd-module-alias', '', d)}"
# From meta-rdk-comcast/recipes-common/lighttpd/lighttpd_1.4.53.bbappend
FILESEXTRAPATHS:prepend:="${THISDIR}/${PN}:"

SRC_URI:append = " file://lighttpd.conf"

SRC_URI:append:broadband += " file://lighttpd_jst.conf_broadband "
SRC_URI:append:broadband += " file://lighttpd_php.conf_broadband "
SRC_URI:append = " file://CVE-2019-11072.patch "

DEPENDS:append = " zlib openssl"
EXTRA_OECONF:append = " --without-bzip2 --without-mysql --with-zlib --with-openssl"

SYSTEMD_SERVICE:${PN}_broadband = ""
INITSCRIPT_NAME:broadband = ""
INITSCRIPT_PARAMS:broadband = ""

RDEPENDS:${PN} += "\
                lighttpd-module-alias \
                lighttpd-module-proxy \
                lighttpd-module-fastcgi \
"

do_install:append() {
     install -d ${D}${sysconfdir}/lighttpd
	 install -m 0644 ${WORKDIR}/lighttpd.conf ${D}${sysconfdir}/lighttpd
     #mod_alias is already part of conf, we can add the two entries to the end of conf file 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'offline_apps', 'true', 'false', d)}; then
        #Remove the generic version added
        rm -f ${D}${sysconfdir}/lighttpd.d/offline_apps.conf
        cat ${WORKDIR}/offline_apps.conf >>${D}${sysconfdir}/lighttpd/lighttpd.conf
     fi
}

do_install:append:broadband() {
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

FILES:${PN} += "${sysconfdir}/lighttpd/lighttpd.conf"
FILES:${PN}:remove_broadband += "${sysconfdir}/lighttpd/lighttpd.conf"
# From meta-rdk-comcast-video/recipes-common/lighttpd/lighttpd_1.4.53.bbappend
FILESEXTRAPATHS:prepend:="${THISDIR}/${PN}:"
SRC_URI:append = " file://CVE-2022-22707_fix.patch "
