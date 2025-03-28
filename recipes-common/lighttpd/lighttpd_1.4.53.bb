SUMMARY = "Lightweight high-performance web server"
HOMEPAGE = "http://www.lighttpd.net/"
BUGTRACKER = "http://redmine.lighttpd.net/projects/lighttpd/issues"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=e4dac5c6ab169aa212feb5028853a579"

SECTION = "net"
RDEPENDS:${PN} = "lighttpd-module-dirlisting \
                  lighttpd-module-indexfile \
                  lighttpd-module-staticfile"
RRECOMMENDS:${PN} = "lighttpd-module-access \
                     lighttpd-module-accesslog"

SRC_URI = "http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${PV}.tar.xz \
        file://index.html.lighttpd \
        file://lighttpd.conf \
        file://lighttpd \
        file://0001-Use-pkg-config-for-pcre-dependency-instead-of-config.patch \
        file://lighttpd.service \
        file://offline_apps.conf \
        "

SRC_URI[md5sum] = "f93436d8d400b2b0e26ee4bcc60b9ac7"
SRC_URI[sha256sum] = "3bdfce1cf3e9650a556a8c26fb15342c5717c63f530c54693db632b0371dcb78"

PACKAGECONFIG ??= "openssl pcre zlib \
    ${@bb.utils.contains('DISTRO_FEATURES', 'ipv6', 'ipv6', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'attr', '', d)} \
"

PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6"
PACKAGECONFIG[mmap] = "--enable-mmap,--disable-mmap"
PACKAGECONFIG[libev] = "--with-libev,--without-libev,libev"
PACKAGECONFIG[mysql] = "--with-mysql,--without-mysql,mariadb"
PACKAGECONFIG[ldap] = "--with-ldap,--without-ldap,openldap"
PACKAGECONFIG[attr] = "--with-attr,--without-attr,attr"
PACKAGECONFIG[valgrind] = "--with-valgrind,--without-valgrind,valgrind"
PACKAGECONFIG[openssl] = "--with-openssl,--without-openssl,openssl"
PACKAGECONFIG[krb5] = "--with-krb5,--without-krb5,krb5"
PACKAGECONFIG[pcre] = "--with-pcre,--without-pcre,libpcre"
PACKAGECONFIG[zlib] = "--with-zlib,--without-zlib,zlib"
PACKAGECONFIG[bzip2] = "--with-bzip2,--without-bzip2,bzip2"
PACKAGECONFIG[fam] = "--with-fam,--without-fam,gamin"
PACKAGECONFIG[webdav-props] = "--with-webdav-props,--without-webdav-props,libxml2 sqlite3"
PACKAGECONFIG[webdav-locks] = "--with-webdav-locks,--without-webdav-locks,util-linux"
PACKAGECONFIG[gdbm] = "--with-gdbm,--without-gdbm,gdbm"
PACKAGECONFIG[memcache] = "--with-memcached,--without-memcached,libmemcached"
PACKAGECONFIG[lua] = "--with-lua,--without-lua,lua5.1"

EXTRA_OECONF += "--enable-lfs"

inherit autotools pkgconfig update-rc.d gettext systemd

INITSCRIPT_NAME = "lighttpd"
INITSCRIPT_PARAMS = "defaults 70"

SYSTEMD_SERVICE:${PN} = "lighttpd.service"

do_install:append() {
	install -d ${D}${sysconfdir}/init.d ${D}${sysconfdir}/lighttpd ${D}${sysconfdir}/lighttpd.d ${D}/www/pages/dav
	install -m 0755 ${WORKDIR}/lighttpd ${D}${sysconfdir}/init.d
	install -m 0644 ${WORKDIR}/lighttpd.conf ${D}${sysconfdir}/lighttpd
	install -m 0644 ${WORKDIR}/index.html.lighttpd ${D}/www/pages/index.html

	install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/lighttpd.service ${D}${systemd_unitdir}/system
	sed -i -e 's,@SBINDIR@,${sbindir},g' \
		-e 's,@SYSCONFDIR@,${sysconfdir},g' \
		-e 's,@BASE_BINDIR@,${base_bindir},g' \
		${D}${systemd_unitdir}/system/lighttpd.service
	#For FHS compliance, create symbolic links to /var/log and /var/tmp for logs and temporary data
	ln -sf ${localstatedir}/log ${D}/www/logs
	ln -sf ${localstatedir}/tmp ${D}/www/var
    
    if ${@bb.utils.contains('DISTRO_FEATURES', 'offline_apps', 'true', 'false', d)}; then
       install -m 0644 ${WORKDIR}/offline_apps.conf ${D}${sysconfdir}/lighttpd.d/
    fi

}

FILES:${PN} += "${sysconfdir} /www"

CONFFILES:${PN} = "${sysconfdir}/lighttpd/lighttpd.conf"

PACKAGES_DYNAMIC += "^lighttpd-module-.*"

python populate_packages:prepend () {
    lighttpd_libdir = d.expand('${libdir}')
    do_split_packages(d, lighttpd_libdir, r'^mod_(.*)\.so$', 'lighttpd-module-%s', 'Lighttpd module for %s', extra_depends='')
}
