SUMMARY = "GNU Transport Layer Security Library"
HOMEPAGE = "http://www.gnu.org/software/gnutls/"
BUGTRACKER = "https://savannah.gnu.org/support/?group=gnutls"

LICENSE = "GPL-3.0-or-later & LGPL-2.1-or-later"
LICENSE:${PN} = "LGPL-2.1-or-later"
LICENSE:${PN}-xx = "LGPL-2.1-or-later"
LICENSE:${PN}-bin = "GPL-3.0-or-later"
LICENSE:${PN}-OpenSSL = "GPL-3.0-or-later"

LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LESSER;md5=a6f89e2100d9b6cdffcea4f398e37343"

DEPENDS = "nettle gmp virtual/libiconv"
DEPENDS:append:libc-musl = " argp-standalone"

SHRT_VER = "${@d.getVar('PV').split('.')[0]}.${@d.getVar('PV').split('.')[1]}"

SRC_URI = "https://www.gnupg.org/ftp/gcrypt/gnutls/v${SHRT_VER}/gnutls-${PV}.tar.xz"

inherit autotools texinfo binconfig pkgconfig gettext lib_package gtk-doc

PACKAGECONFIG ??= "zlib"

PACKAGECONFIG[libtasn1] = "--with-included-libtasn1=no,--with-included-libtasn1,libtasn1"
PACKAGECONFIG[p11-kit] = "--with-p11-kit,--without-p11-kit,p11-kit"
PACKAGECONFIG[tpm] = "--with-tpm,--without-tpm,trousers"
PACKAGECONFIG[zlib] = "--with-zlib,--without-zlib,zlib"

EXTRA_OECONF = " \
    --enable-doc \
    --disable-crywrap \
    --disable-libdane \
    --disable-guile \
    --disable-rpath \
    --enable-local-libopts \
    --enable-openssl-compatibility \
    --with-libpthread-prefix=${STAGING_DIR_HOST}${prefix} \
"

LDFLAGS:append:libc-musl = " -largp"
LDFLAGS:append:libc-uclibc = " -luargp -pthread"

do_configure:prepend() {
	for dir in . lib; do
		rm -f ${dir}/aclocal.m4 ${dir}/m4/libtool.m4 ${dir}/m4/lt*.m4
	done
}

PACKAGES =+ "${PN}-openssl ${PN}-xx"

FILES:${PN}-dev += "${bindir}/gnutls-cli-debug"
FILES:${PN}-openssl = "${libdir}/libgnutls-openssl.so.*"
FILES:${PN}-xx = "${libdir}/libgnutlsxx.so.*"

BBCLASSEXTEND = "native nativesdk"
