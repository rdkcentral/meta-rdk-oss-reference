SUMMARY = "Rotates, compresses, removes and mails system log files"
SECTION = "console/utils"
HOMEPAGE = "https://github.com/logrotate/logrotate/"
DESCRIPTION = "The logrotate utility is designed to simplify the administration of log files on a system which generates a lot of log files."
LICENSE = "GPL-2.0-only"

# TODO: Document coreutils dependency. Why not RDEPENDS? Why not busybox?

DEPENDS="coreutils popt"

LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

GITHUB_BASE_URI ?= "https://github.com/${BPN}/${BPN}/releases/"
UPSTREAM_CHECK_URI ?= "${GITHUB_BASE_URI}"
UPSTREAM_CHECK_REGEX ?= "releases/tag/v?(?P<pver>\d+(\.\d+)+)"

SRC_URI = "${GITHUB_BASE_URI}/download/${PV}/${BP}.tar.xz \
           "
SRC_URI[sha256sum] = "8fa12015e3b8415c121fc9c0ca53aa872f7b0702f543afda7e32b6c4900f6516"

SRC_URI += "file://logrotate.service \
            file://logrotate.timer"

inherit systemd

SYSTEMD_SERVICE:${PN} = "logrotate.timer"

FILES:${PN} += "${systemd_system_unitdir}/logrotate.service \
                ${systemd_system_unitdir}/logrotate.timer"

# These CVEs are debian, gentoo or SUSE specific on the way logrotate was installed/used
CVE_CHECK_IGNORE += "CVE-2011-1548 CVE-2011-1549 CVE-2011-1550"

CONFFILES:${PN} += "${localstatedir}/lib/logrotate.status \
                    ${sysconfdir}/logrotate.conf \
                    ${sysconfdir}/logrotate.d/btmp \
                    ${sysconfdir}/logrotate.d/wtmp"

# If RPM_OPT_FLAGS is unset, it adds -g itself rather than obeying our
# optimization variables, so use it rather than EXTRA_CFLAGS.
EXTRA_OEMAKE = "\
    LFS= \
    OS_NAME='${OS_NAME}' \
    'CC=${CC}' \
    'RPM_OPT_FLAGS=${CFLAGS}' \
    'EXTRA_LDFLAGS=${LDFLAGS}' \
    ${@bb.utils.contains('PACKAGECONFIG', 'acl', 'WITH_ACL=yes', '', d)} \
    ${@bb.utils.contains('PACKAGECONFIG', 'selinux', 'WITH_SELINUX=yes', '', d)} \
"

# OS_NAME in the makefile defaults to `uname -s`. The behavior for
# freebsd/netbsd is questionable, so leave it as Linux, which only sets
# INSTALL=install and BASEDIR=/usr.
OS_NAME = "Linux"

inherit autotools systemd syslog-ng-config-gen logrotate_config

SYSLOG-NG_FILTER = "logrotate"
SYSLOG-NG_SERVICE_logrotate = "logrotate.service"
SYSLOG-NG_DESTINATION_logrotate = "logrotate.log"
SYSLOG-NG_LOGRATE_logrotate = "medium"

LOGROTATE_NAME="logrotate"
LOGROTATE_LOGNAME_logrotate="logrotate.log"
#HDD_ENABLE
LOGROTATE_SIZE_logrotate="1572864"
LOGROTATE_ROTATION_logrotate="3"
#HDD_DISABLE
LOGROTATE_SIZE_MEM_logrotate="1572864"
LOGROTATE_ROTATION_MEM_logrotate="3"

LOGROTATE_OPTIONS ?= ""

LOGROTATE_SYSTEMD_TIMER_BASIS ?= "daily"
LOGROTATE_SYSTEMD_TIMER_ACCURACY ?= "12h"
LOGROTATE_SYSTEMD_TIMER_PERSISTENT ?= "true"

do_install(){
    oe_runmake install DESTDIR=${D} PREFIX=${D} MANDIR=${mandir}
    mkdir -p ${D}${sysconfdir}/logrotate.d
    mkdir -p ${D}${localstatedir}/lib
    install -p -m 644 ${S}/examples/logrotate.conf ${D}${sysconfdir}/logrotate.conf
    install -p -m 644 ${S}/examples/btmp ${D}${sysconfdir}/logrotate.d/btmp
    install -p -m 644 ${S}/examples/wtmp ${D}${sysconfdir}/logrotate.d/wtmp
    touch ${D}${localstatedir}/lib/logrotate.status

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/logrotate.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/logrotate.timer ${D}${systemd_unitdir}/system

   

    if ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'true', 'false', d)}; then
        mkdir -p ${D}${sysconfdir}/cron.daily
        install -p -m 0755 ${S}/examples/logrotate.cron ${D}${sysconfdir}/cron.daily/logrotate
    fi
}


do_install:append:client(){
    install -m 0644 ${S}/logrotate_nohdd.conf ${D}${sysconfdir}/logrotatemax.conf
}
