SUMMARY = "Secure Socket Layer"
DESCRIPTION = "Secure Socket Layer (SSL) binary and related cryptographic tools."
HOMEPAGE = "http://www.openssl.org/"
BUGTRACKER = "http://www.openssl.org/news/vulnerabilities.html"
SECTION = "libs/network"

# "openssl" here actually means both OpenSSL and SSLeay licenses apply
# (see meta/files/common-licenses/OpenSSL to which "openssl" is SPDXLICENSEMAPped)
LICENSE = "openssl"
LIC_FILES_CHKSUM = "file://LICENSE;md5=d343e62fc9c833710bbbed25f27364c8"

DEPENDS = "hostperl-runtime-native"

SRC_URI = "http://www.openssl.org/source/openssl-${PV}.tar.gz \
           file://run-ptest \
           file://0001-skip-test_symbol_presence.patch \
           file://0001-buildinfo-strip-sysroot-and-debug-prefix-map-from-co.patch \
           file://afalg.patch \
           file://reproducible.patch \
           "

SRC_URI:append:class-nativesdk = " \
           file://environment.d-openssl.sh \
           "
S = "${WORKDIR}/openssl-${PV}"

SRC_URI[sha256sum] = "0b7a3e5e59c34827fe0c3a74b7ec8baef302b98fa80088d7f9153aa16fa76bd1"

inherit lib_package multilib_header multilib_script ptest
MULTILIB_SCRIPTS = "${PN}-bin:${bindir}/c_rehash"

PACKAGECONFIG ?= ""
PACKAGECONFIG:class-native = ""
PACKAGECONFIG:class-nativesdk = ""

#PACKAGECONFIG[cryptodev-linux] = "enable-devcryptoeng,disable-devcryptoeng,cryptodev-linux,,cryptodev-module"

B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

#| ./libcrypto.so: undefined reference to `getcontext'
#| ./libcrypto.so: undefined reference to `setcontext'
#| ./libcrypto.so: undefined reference to `makecontext'
EXTRA_OECONF:append:libc-musl = " no-async"
EXTRA_OECONF:append:libc-musl:powerpc64 = " no-asm"

# adding devrandom prevents openssl from using getrandom() which is not available on older glibc versions
# (native versions can be built with newer glibc, but then relocated onto a system with older glibc)
EXTRA_OECONF:class-native = "--with-rand-seed=os,devrandom"
EXTRA_OECONF:class-nativesdk = "--with-rand-seed=os,devrandom"

# Relying on hardcoded built-in paths causes openssl-native to not be relocateable from sstate.
CFLAGS:append:class-native = " -DOPENSSLDIR=/not/builtin -DENGINESDIR=/not/builtin"
CFLAGS:append:class-nativesdk = " -DOPENSSLDIR=/not/builtin -DENGINESDIR=/not/builtin"

do_configure () {
	os=${HOST_OS}
	case $os in
	linux-gnueabi |\
	linux-gnuspe |\
	linux-musleabi |\
	linux-muslspe |\
	linux-musl )
		os=linux
		;;
	*)
		;;
	esac
	target="$os-${HOST_ARCH}"
	case $target in
	linux-arm*)
		target=linux-armv4
		;;
	linux-aarch64*)
		target=linux-aarch64
		;;
	linux-i?86 | linux-viac3)
		target=linux-x86
		;;
	linux-gnux32-x86_64 | linux-muslx32-x86_64 )
		target=linux-x32
		;;
	linux-gnu64-x86_64)
		target=linux-x86_64
		;;
	linux-mips | linux-mipsel)
		# specifying TARGET_CC_ARCH prevents openssl from (incorrectly) adding target architecture flags
		target="linux-mips32 ${TARGET_CC_ARCH}"
		;;
	linux-gnun32-mips*)
		target=linux-mips64
		;;
	linux-*-mips64 | linux-mips64 | linux-*-mips64el | linux-mips64el)
		target=linux64-mips64
		;;
	linux-microblaze* | linux-nios2* | linux-sh3 | linux-sh4 | linux-arc*)
		target=linux-generic32
		;;
	linux-powerpc)
		target=linux-ppc
		;;
	linux-powerpc64)
		target=linux-ppc64
		;;
	linux-powerpc64le)
		target=linux-ppc64le
		;;
	linux-riscv32)
		target=linux-generic32
		;;
	linux-riscv64)
		target=linux-generic64
		;;
	linux-sparc | linux-supersparc)
		target=linux-sparcv9
		;;
	esac

	useprefix=${prefix}
	if [ "x$useprefix" = "x" ]; then
		useprefix=/
	fi
	# WARNING: do not set compiler/linker flags (-I/-D etc.) in EXTRA_OECONF, as they will fully replace the
	# environment variables set by bitbake. Adjust the environment variables instead.
	HASHBANGPERL="/usr/bin/env perl" PERL=perl PERL5LIB="${S}/external/perl/Text-Template-1.46/lib/" \
	perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS} --prefix=$useprefix --openssldir=${libdir}/ssl-1.1 --libdir=${libdir} $target
	perl ${B}/configdata.pm --dump
}

do_install () {
        install -d ${D}${libdir}
        install -d ${D}${bindir}
        install -d ${D}${includedir}/openssl-1.1.1l

      	oe_runmake DESTDIR="${D}" install_sw
	oe_multilib_header openssl/opensslconf.h

        sed -i '/^includedir=/ s%$%\/openssl-1.1.1l%' ${D}/${libdir}/pkgconfig/*.pc
        sed -i s%\-lcrypto%\-lcrypto-1.1.1l% ${D}/${libdir}/pkgconfig/*.pc
        sed -i s%\-lssl%\-lssl-1.1.1l% ${D}/${libdir}/pkgconfig/*.pc
        mv ${D}${includedir}/openssl ${D}${includedir}/openssl-1.1.1l
        mv ${D}${bindir}/openssl ${D}${bindir}/openssl-1.1.1l
        mv ${D}${libdir}/libssl.so ${D}${libdir}/libssl-1.1.1l.so
        mv ${D}${libdir}/libcrypto.so ${D}${libdir}/libcrypto-1.1.1l.so
        mv ${D}${libdir}/libssl.a ${D}${libdir}/libssl-1.1.1l.a
        mv ${D}${libdir}/libcrypto.a ${D}${libdir}/libcrypto-1.1.1l.a
        mv ${D}${libdir}/pkgconfig/libcrypto.pc ${D}${libdir}/pkgconfig/libcrypto-1.1.1l.pc
        mv ${D}${libdir}/pkgconfig/libssl.pc ${D}${libdir}/pkgconfig/libssl-1.1.1l.pc
        mv ${D}${libdir}/pkgconfig/openssl.pc ${D}${libdir}/pkgconfig/openssl-1.1.1l.pc
        rm -rf ${D}${libdir}/ssl ${D}${libdir}/engines
}

do_install:append:class-native () {
	create_wrapper ${D}${bindir}/openssl \
	    OPENSSL_CONF=${libdir}/ssl-1.1/openssl.cnf \
	    SSL_CERT_DIR=${libdir}/ssl-1.1/certs \
	    SSL_CERT_FILE=${libdir}/ssl-1.1/cert.pem \
	    OPENSSL_ENGINES=${libdir}/engines-1.1
}

do_install:append:class-nativesdk () {
	mkdir -p ${D}${SDKPATHNATIVE}/environment-setup.d
	install -m 644 ${WORKDIR}/environment.d-openssl.sh ${D}${SDKPATHNATIVE}/environment-setup.d/openssl.sh
	sed 's|/usr/lib/ssl/|/usr/lib/ssl-1.1/|g' -i ${D}${SDKPATHNATIVE}/environment-setup.d/openssl.sh
}

PTEST_BUILD_HOST_FILES += "configdata.pm"
PTEST_BUILD_HOST_PATTERN = "perl_version ="
do_install_ptest () {
	# Prune the build tree
	rm -f ${B}/fuzz/*.* ${B}/test/*.*

	cp ${S}/Configure ${B}/configdata.pm ${D}${PTEST_PATH}
	cp -r ${S}/external ${B}/test ${S}/test ${B}/fuzz ${S}/util ${B}/util ${D}${PTEST_PATH}

	# For test_shlibload
	ln -s ${libdir}/libcrypto.so.1.1 ${D}${PTEST_PATH}/
	ln -s ${libdir}/libssl.so.1.1 ${D}${PTEST_PATH}/

	install -d ${D}${PTEST_PATH}/apps
	ln -s ${bindir}/openssl ${D}${PTEST_PATH}/apps
	install -m644 ${S}/apps/*.pem ${S}/apps/*.srl ${S}/apps/openssl.cnf ${D}${PTEST_PATH}/apps
	install -m755 ${B}/apps/CA.pl ${D}${PTEST_PATH}/apps

	install -d ${D}${PTEST_PATH}/engines
	install -m755 ${B}/engines/ossltest.so ${D}${PTEST_PATH}/engines
}

# Add the openssl.cnf file to the openssl-conf package. Make the libcrypto
# package RRECOMMENDS on this package. This will enable the configuration
# file to be installed for both the openssl-bin package and the libcrypto
# package since the openssl-bin package depends on the libcrypto package.

PACKAGES =+ "libcrypto-1.1.1l libssl-1.1.1l openssl-conf-1.1.1l ${PN}-engines ${PN}-misc"

PROVIDES += "libssl-1.1.1l"
RPROVIDES:${PN} += "libssl-1.1.1l"

FILES:libcrypto-1.1.1l = "${libdir}/libcrypto-1.1.1l${SOLIBS}"
FILES:libssl-1.1.1l = "${libdir}/libssl-1.1.1l${SOLIBS}"
FILES:openssl-conf = "${sysconfdir}/ssl/openssl.cnf \
                      ${libdir}/ssl-1.1/openssl.cnf* \
                      "
FILES:${PN}-engines = "${libdir}/engines-1.1"
FILES:${PN}-misc = "${libdir}/ssl-1.1/misc"
FILES:${PN} =+ "${libdir}/ssl-1.1/*"
FILES:${PN}:append:class-nativesdk = " ${SDKPATHNATIVE}/environment-setup.d/openssl.sh"

CONFFILES:openssl-conf = "${sysconfdir}/ssl/openssl.cnf"

RRECOMMENDS:libcrypto += "openssl-conf"
RDEPENDS:${PN}-ptest += "openssl-bin perl perl-modules bash"
RDEPENDS:${PN}-bin += "openssl-conf"

BBCLASSEXTEND = "native nativesdk"

CVE_PRODUCT = "openssl:openssl"
CVE_VERSION_SUFFIX = "alphabetical"
# Only affects OpenSSL >= 1.1.1 in combination with Apache < 2.4.37
# Apache in meta-webserver is already recent enough
CVE_CHECK_IGNORE += "CVE-2019-0190"
