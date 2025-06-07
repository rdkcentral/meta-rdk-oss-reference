FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

RDEPENDS:${PN} += " \
    libpcreposix \
    pcregrep \
    lighttpd-module-cgi \
    lighttpd-module-redirect \
    lighttpd-module-setenv \
    lighttpd-module-ssi \
    lighttpd-module-access \
    lighttpd-module-accesslog \
	"
# From meta-rdk-comcast/recipes-common/lighttpd/lighttpd_%.bbappend
FILESEXTRAPATHS:prepend:="${THISDIR}/files:"

inherit logrotate_config

LOGROTATE_NAME    = "lighttpd"
LOGROTATE_LOGNAME_lighttpd = "lighttpd*.log"
#HDD_ENABLE
LOGROTATE_SIZE_lighttpd    = "1048576"
LOGROTATE_ROTATION_lighttpd  = "1"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_lighttpd    = "204800"
LOGROTATE_ROTATION_MEM_lighttpd  = "1"

SRC_URI:append:qemux86 ="file://lighttpd.conf_emulator "

SRC_URI:append = " file://0001-Force-UTC-for-lighttpd-log-messages.patch "
SRC_URI:append:broadband = " file://drop_root_lighttpd.patch "

DEPENDS:append:broadband = " utopia libunpriv"

CFLAGS:append:broadband = " \
    -I${STAGING_INCDIR}/syscfg \
    "

LDFLAGS:append:broadband = " -lprivilege -lsyscfg"

RDEPENDS:${PN} += " \
       libpcreposix \
       pcregrep \
       lighttpd-module-cgi \
       lighttpd-module-redirect \
       lighttpd-module-setenv \
       lighttpd-module-ssi \
       "
do_install:append:qemux86() {
       install -d ${D}/opt/www ${D}/opt
       install -m 0755 ${WORKDIR}/lighttpd.conf_emulator ${D}${sysconfdir}
       mv ${D}${sysconfdir}/lighttpd.conf_emulator ${D}${sysconfdir}/lighttpd.conf
}

FILES:${PN}:append:qemux86 += "/opt"

# From meta-rdk-comcast-video/recipes-common/lighttpd/lighttpd_%.bbappend
# Modifies the lighttpd.conf file to add an extra alias.url for firebolt root app if this is cert build.
do_install:append () {
  if ${@bb.utils.contains('DISTRO_FEATURES','firebolt_rdk_certify','true','false',d)}; then
   
    sed -i -e 's|alias.url += ( "/easterEggsMenu/" => "/var/www/easterEggsMenu/" )|alias.url += ( "/easterEggsMenu/" => "/var/www/easterEggsMenu/" )\nalias.url += ( "/firebolt-root-app/" => "/var/www/firebolt-root-app/" )|g' ${D}/${sysconfdir}/lighttpd/lighttpd.conf
   
  fi
}
