SUMMARY = "Pattern matching utilities"
DESCRIPTION = "The GNU versions of commonly used grep utilities.  The grep command searches one or more input \
files for lines containing a match to a specified pattern."
SECTION = "console/utils"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"

PR = "r2"

SRC_URI = "${GNU_MIRROR}/grep/grep-${PV}.tar.bz2 \
           file://uclibc-fix.patch \
           file://grep_fix_for_automake-1.12.patch \
           file://gettext.patch \
           file://fix64-int-to-pointer.patch \
           file://Makevars \
           file://grep-CVE-2012-5667.patch \
           file://fix-for-texinfo-5.1.patch \
           file://grep-egrep-fgrep-Fix-LSB-NG-cases.patch \
           file://search-fix-compilation-error-with-security-flags-ena.patch \
           file://0001-Fix-builds-with-gettext-0.20.patch \
           file://autoconf270.patch \
           "

SRC_URI[md5sum] = "52202fe462770fa6be1bb667bd6cf30c"
SRC_URI[sha256sum] = "38c8a2bb9223d1fb1b10bdd607cf44830afc92fd451ac4cd07619bf92bdd3132"

inherit autotools gettext texinfo

EXTRA_OECONF_INCLUDED_REGEX = "--without-included-regex"
EXTRA_OECONF_INCLUDED_REGEX:libc-musl = "--with-included-regex"
# --without-included-regex is not recognised by grep 2.5.1a's configure (it was
# handled by the jm_INCLUDED_REGEX macro which we stub to jm_with_regex=no via sed).
# Passing it causes do_qa_configure to fail with unknown-configure-option.
EXTRA_OECONF_INCLUDED_REGEX:wrynose = ""

# Disable NLS for wrynose: AM_GNU_GETTEXT([external]) in configure.in was never
# expanded in the pre-generated configure, leaving @CATALOGS@ and other variables
# unresolved in po/Makefile and intl/Makefile. Disabling NLS prevents the intl/po
# directories from being built entirely, avoiding the entire cascade of failures.
EXTRA_OECONF:append:wrynose = " --disable-nls"

EXTRA_OECONF = "--disable-perl-regexp \
                ${EXTRA_OECONF_INCLUDED_REGEX}"

CFLAGS += "-D PROTOTYPES"
# GCC 15 defaults to C23 where empty-parameter declarations like 'long int strtol()'
# conflict with glibc prototypes (C23 treats () as (void), not K&R unspecified).
# Drop to gnu11 to keep K&R compatibility for this 2004-era source.
# Also suppress: implicit-function-declaration (savedir.c calls isdir() before def),
# incompatible-pointer-types (dfa.c MALLOC macro casts wchar_t* to wctype_t*).
CFLAGS:append:wrynose = " -std=gnu11 -Wno-implicit-function-declaration -Wno-error=incompatible-pointer-types"
do_configure () {
    cp -f ${UNPACKDIR}/Makevars ${S}/po/
    # The tarball lacks config.rpath (required by AM_GNU_GETTEXT) and compile
    # (required by automake). gnu-configize/autoreconf cannot install them because
    # old gnulib macros cause aclocal to fail before automake (which installs
    # compile) can run. Install them directly from the native sysroot.
    install -m 0644 ${STAGING_DATADIR_NATIVE}/gettext/config.rpath ${S}/
    install -m 0755 ${STAGING_DATADIR_NATIVE}/automake-1.18/compile ${S}/compile
    # Update config.sub/config.guess for cross-compilation target
    install -m 0755 ${STAGING_DATADIR_NATIVE}/gnu-config/config.sub ${S}/
    install -m 0755 ${STAGING_DATADIR_NATIVE}/gnu-config/config.guess ${S}/
    # The pre-generated configure has unexpanded gnulib/gettext m4 macros from ~2002.
    # On modern /bin/sh these fail: bare names cause 'not found' errors and macro
    # calls with parentheses (jm_CHECK_DECLARATIONS(...)) cause syntax errors.
    # Stub them out with no-ops or equivalent minimal shell code for Linux/aarch64.
    sed -i \
        -e '/^jm_AC_TYPE_UINTMAX_T$/d' \
        -e '/^AC_MBSTATE_T$/d' \
        -e '/^jm_AC_PREREQ_XSTRTOUMAX$/d' \
        -e '/^jm_CHECK_DECLARATIONS/c\jm_cv_func_decl_strtoul=yes; jm_cv_func_decl_strtoull=yes' \
        -e '/^AC_DOSFILE$/d' \
        -e '/^AM_SEP$/d' \
        -e '/^jm_INCLUDED_REGEX/c\jm_with_regex=no' \
        -e '/^jm_PREREQ_ERROR$/d' \
        -e '/^jm_FUNC_MALLOC$/d' \
        -e '/^jm_FUNC_REALLOC$/d' \
        ${S}/configure
    oe_runconf
    # AM_GNU_GETTEXT([external]) in configure.in was never expanded in the
    # pre-generated configure. config.status therefore leaves @VAR@ literals in
    # intl/Makefile (USE_INCLUDED_LIBINTL, BUILD_INCLUDED_LIBINTL, CATALOGS, etc.).
    # Patch the generated Makefile to resolve them for an external-gettext build
    # (even with --disable-nls, intl/ is listed in SUBDIRS and make enters it).
    sed -i \
        -e 's/@USE_INCLUDED_LIBINTL@/no/g' \
        -e 's/@BUILD_INCLUDED_LIBINTL@/no/g' \
        -e 's/@INTLOBJS@//g' \
        -e 's/@GETTOBJS@//g' \
        -e 's|@INTLBISON@|:|g' \
        -e 's/@INTL_LIBTOOL_SUFFIX_PREFIX@//g' \
        -e 's/@MKINSTALLDIRS@/mkdir -p/g' \
        ${B}/intl/Makefile
    # po/Makefile may also have unresolved @CATALOGS@ from AM_GNU_GETTEXT
    sed -i \
        -e 's/@CATALOGS@//g' \
        ${B}/po/Makefile || true
}

# Prevent make from re-running legacy autotools if source timestamps trigger it
# (configure.in is newer than the generated Makefile after autoreconf touch).
# MAKEINFO=: skips building doc/grep.info (texinfo-dummy-native cannot handle
# the old grep.texi format used by this 2004-era recipe).
EXTRA_OEMAKE += "AUTOCONF=: AUTOMAKE=: ACLOCAL=: AUTOHEADER=: MAKEINFO=:"

do_install () {
	autotools_do_install
        if [ "${base_bindir}" != "${bindir}" ]; then
        	install -d ${D}${base_bindir}
	        mv ${D}${bindir}/grep ${D}${base_bindir}/grep
	        mv ${D}${bindir}/egrep ${D}${base_bindir}/egrep
	        mv ${D}${bindir}/fgrep ${D}${base_bindir}/fgrep
	        rmdir ${D}${bindir}/
        fi
}

inherit update-alternatives

ALTERNATIVE_PRIORITY = "100"

ALTERNATIVE:${PN} = "grep egrep fgrep"
ALTERNATIVE_LINK_NAME[grep] = "${base_bindir}/grep"
ALTERNATIVE_LINK_NAME[egrep] = "${base_bindir}/egrep"
ALTERNATIVE_LINK_NAME[fgrep] = "${base_bindir}/fgrep"

export CONFIG_SHELL="/bin/sh"
