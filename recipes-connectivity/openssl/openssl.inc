SUMMARY = "Secure Socket Layer"
DESCRIPTION = "Secure Socket Layer (SSL) binary and related cryptographic tools."
HOMEPAGE = "http://www.openssl.org/"
BUGTRACKER = "http://www.openssl.org/news/vulnerabilities.html"
SECTION = "libs/network"

# "openssl | SSLeay" dual license
LICENSE = "OpenSSL"
LIC_FILES_CHKSUM = "file://LICENSE;md5=f9a8f968107345e0b75aa8c2ecaa7ec8"

DEPENDS = "makedepend-native hostperl-runtime-native"

DEPENDS:append:class-target = " openssl-native"

PROVIDES += "openssl10"

SRC_URI = "http://www.openssl.org/source/openssl-${PV}.tar.gz \
          "
S = "${WORKDIR}/openssl-${PV}"

PACKAGECONFIG[perl] = ",,,"

EXTRA_OECONF += "no-camellia"
EXTRA_OECONF += "no-seed"
EXTRA_OECONF += "no-rc5"
EXTRA_OECONF += "no-md2"
EXTRA_OECONF += "no-md4"
EXTRA_OECONF += "no-ripemd"
EXTRA_OECONF += "no-mdc2"
EXTRA_OECONF += "no-ssl2"
EXTRA_OECONF += "no-ssl3"
EXTRA_OECONF += "no-err"
EXTRA_OECONF += "no-krb5"
EXTRA_OECONF += "no-hw"
EXTRA_OECONF += "no-srp"
EXTRA_OECONF += "no-idea"
EXTRA_OECONF += "no-rc4"

AR:append = " r"
TERMIO:libc-musl = "-DTERMIOS"
TERMIO ?= "-DTERMIO"
# Avoid binaries being marked as requiring an executable stack since it
# doesn't(which causes and this causes issues with SELinux
CFLAG = "${@oe.utils.conditional('SITEINFO_ENDIANNESS', 'le', '-DL_ENDIAN', '-DB_ENDIAN', d)} \
	 ${TERMIO} ${CFLAGS} -Wall -Wa,--noexecstack"

export DIRS = "crypto ssl apps"
export EX_LIBS = "-lgcc -ldl"
export AS = "${CC} -c"
EXTRA_OEMAKE = "-e MAKEFLAGS="

inherit pkgconfig siteinfo multilib_header ptest

# ----------------------------------------------------------------------------
# BEGIN : Backport of "relative_symlinks" class from OE 2.3
# ----------------------------------------------------------------------------
# Postprocess ${D} to replace absolute symlinks with relative symlinks. Avoids
# triggering "absolute path symlink" build time errors when building the
# meta-rdk openssl recipe with OE 2.3. In OE 2.3 the same postprocessing is
# done by inheritting the "relative_symlinks" class, however since that class
# is only available from OE 2.3 onwards, provide the same logic directly in the
# openssl recipe to be compatible with OE 1.6, OE 2.1 and OE 2.2.
# ----------------------------------------------------------------------------

def openssl_replace_absolute_symlinks(basedir, d):
    """
    Walk basedir looking for absolute symlinks and replacing them with relative ones.
    The absolute links are assumed to be relative to basedir
    (compared to make_relative_symlink above which tries to compute common ancestors
    using pattern matching instead)
    """
    for walkroot, dirs, files in os.walk(basedir):
        for file in files + dirs:
            path = os.path.join(walkroot, file)
            if not os.path.islink(path):
                continue
            link = os.readlink(path)
            if not os.path.isabs(link):
                continue
            walkdir = os.path.dirname(path.rpartition(basedir)[2])
            base = os.path.relpath(link, walkdir)
            bb.debug(2, "Replacing absolute path %s with relative path %s" % (link, base))
            os.remove(path)
            os.symlink(base, path)

python install_relative_symlinks () {
    openssl_replace_absolute_symlinks(d.getVar('D', True), d)
}

do_install[postfuncs] += "install_relative_symlinks"

# ----------------------------------------------------------------------------
# END : Backport of "relative_symlinks" class from OE 2.3
# ----------------------------------------------------------------------------

PACKAGES =+ "libcrypto libssl ${PN}-misc openssl-conf"
FILES:libcrypto = "${libdir}/libcrypto${SOLIBS}"
FILES:libssl = "${libdir}/libssl${SOLIBS}"
FILES:${PN} =+ " ${libdir}/ssl/*"
FILES:${PN}-misc = "${libdir}/ssl/misc"
RDEPENDS:${PN}-misc = "${@bb.utils.contains('PACKAGECONFIG', 'perl', 'perl', '', d)}"
FILES:${PN}-dev += "${libdir}/libcrypto${SOLIBSDEV}"

# Add the openssl.cnf file to the openssl-conf package.  Make the libcrypto
# package RRECOMMENDS on this package.  This will enable the configuration
# file to be installed for both the base openssl package and the libcrypto
# package since the base openssl package depends on the libcrypto package.
FILES:openssl-conf = "${sysconfdir}/ssl/openssl.cnf"
CONFFILES:openssl-conf = "${sysconfdir}/ssl/openssl.cnf"
RRECOMMENDS:libcrypto += "openssl-conf"
RDEPENDS:${PN}-ptest += "${PN}-misc make perl perl-module-filehandle bc"

do_configure:prepend:darwin () {
	sed -i -e '/version-script=openssl\.ld/d' Configure
}

do_configure () {
	cd util
	perl perlpath.pl ${STAGING_BINDIR_NATIVE}
	cd ..
	ln -sf apps/openssl.pod crypto/crypto.pod ssl/ssl.pod doc/

	os=${HOST_OS}
	case $os in
	linux-uclibc |\
	linux-uclibceabi |\
	linux-gnueabi |\
	linux-uclibcspe |\
	linux-gnuspe |\
	linux-musl*)
		os=linux
		;;
		*)
		;;
	esac
	target="$os-${HOST_ARCH}"
	case $target in
	linux-arm)
		target=linux-armv4
		;;
	linux-armeb)
		target=linux-elf-armeb
		;;
	linux-aarch64*)
		target=linux-generic64
		;;
	linux-sh3)
		target=debian-sh3
		;;
	linux-sh4)
		target=debian-sh4
		;;
	linux-i486)
		target=debian-i386-i486
		;;
	linux-i586 | linux-viac3)
		target=debian-i386-i586
		;;
	linux-i686)
		target=debian-i386-i686/cmov
		;;
	linux-gnux32-x86_64)
		target=linux-x32
		;;
	linux-gnu64-x86_64)
		target=linux-x86_64
		;;
	linux-mips)
		target=debian-mips
		;;
	linux-mipsel)
		target=debian-mipsel
		;;
        linux-*-mips64 | linux-mips64)
               target=linux-mips
                ;;
	linux-microblaze*|linux-nios2*)
		target=linux-generic32
		;;
	linux-powerpc)
		target=linux-ppc
		;;
	linux-powerpc64)
		target=linux-ppc64
		;;
	linux-supersparc)
		target=linux-sparcv8
		;;
	linux-sparc)
		target=linux-sparcv8
		;;
	darwin-i386)
		target=darwin-i386-cc
		;;
	esac
	# inject machine-specific flags
	sed -i -e "s|^\(\"$target\",\s*\"[^:]\+\):\([^:]\+\)|\1:${CFLAG}|g" Configure
        useprefix=${prefix}
        if [ "x$useprefix" = "x" ]; then
                useprefix=/
        fi        
	perl ./Configure ${EXTRA_OECONF} shared --prefix=$useprefix --openssldir=${libdir}/ssl --libdir=`basename ${libdir}` $target
	make depend
}

do_compile:prepend:class-target () {
    sed -i 's/\((OPENSSL=\)".*"/\1"openssl"/' Makefile
}

do_compile () {
	oe_runmake
}

do_compile_ptest () {
	oe_runmake buildtest
}

do_install () {
	# Create ${D}/${prefix} to fix parallel issues
	mkdir -p ${D}/${prefix}/

	oe_runmake INSTALL_PREFIX="${D}" MANDIR="${mandir}" install

	oe_libinstall -so libcrypto ${D}${libdir}
	oe_libinstall -so libssl ${D}${libdir}

	install -d ${D}${includedir}
	cp --dereference -R include/openssl ${D}${includedir}

	install -Dm 0755 ${WORKDIR}/openssl-c_rehash.sh ${D}${bindir}/c_rehash
	sed -i -e 's,/etc/openssl,${sysconfdir}/ssl,g' ${D}${bindir}/c_rehash

	oe_multilib_header openssl/opensslconf.h
	if [ "${@bb.utils.contains('PACKAGECONFIG', 'perl', 'perl', '', d)}" = "perl" ]; then
		sed -i -e '1s,.*,#!${bindir}/env perl,' ${D}${libdir}/ssl/misc/CA.pl
		sed -i -e '1s,.*,#!${bindir}/env perl,' ${D}${libdir}/ssl/misc/tsget
	else
		rm -f ${D}${libdir}/ssl/misc/CA.pl ${D}${libdir}/ssl/misc/tsget
	fi

	# Create SSL structure
	install -d ${D}${sysconfdir}/ssl/
	mv ${D}${libdir}/ssl/openssl.cnf \
	   ${D}${libdir}/ssl/certs \
	   ${D}${libdir}/ssl/private \
	   \
	   ${D}${sysconfdir}/ssl/
	ln -sf ${sysconfdir}/ssl/certs ${D}${libdir}/ssl/certs
	ln -sf ${sysconfdir}/ssl/private ${D}${libdir}/ssl/private
	ln -sf ${sysconfdir}/ssl/openssl.cnf ${D}${libdir}/ssl/openssl.cnf
}

do_install_ptest () {
	cp -r -L Makefile.org Makefile test ${D}${PTEST_PATH}
	cp Configure config e_os.h ${D}${PTEST_PATH}
	cp -r -L include ${D}${PTEST_PATH}
	ln -sf ${base_libdir}/libcrypto.a ${D}${PTEST_PATH}
	ln -sf ${libdir}/libssl.a ${D}${PTEST_PATH}
	mkdir -p ${D}${PTEST_PATH}/crypto
	cp crypto/constant_time_locl.h ${D}${PTEST_PATH}/crypto
	cp -r certs ${D}${PTEST_PATH}
	mkdir -p ${D}${PTEST_PATH}/apps
	ln -sf ${libdir}/ssl/misc/CA.sh  ${D}${PTEST_PATH}/apps
	ln -sf ${sysconfdir}/ssl/openssl.cnf ${D}${PTEST_PATH}/apps
	ln -sf ${bindir}/openssl         ${D}${PTEST_PATH}/apps
	cp apps/server2.pem             ${D}${PTEST_PATH}/apps
	mkdir -p ${D}${PTEST_PATH}/util
	install util/opensslwrap.sh    ${D}${PTEST_PATH}/util
	install util/shlib_wrap.sh     ${D}${PTEST_PATH}/util
}

do_install:append:class-native() {
	create_wrapper ${D}${bindir}/openssl \
	    OPENSSL_CONF=${libdir}/ssl/openssl.cnf \
	    SSL_CERT_DIR=${libdir}/ssl/certs \
	    SSL_CERT_FILE=${libdir}/ssl/cert.pem \
	    OPENSSL_ENGINES=${libdir}/ssl/engines
}

BBCLASSEXTEND = "native nativesdk"
