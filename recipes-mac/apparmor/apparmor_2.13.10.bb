SUMMARY = "AppArmor another MAC control system"
DESCRIPTION = "user-space parser utility for AppArmor \
 This provides the system initialization scripts needed to use the \
 AppArmor Mandatory Access Control system, including the AppArmor Parser \
 which is required to convert AppArmor text profiles into machine-readable \
 policies that are loaded into the kernel for use with the AppArmor Linux \
 Security Module."
HOMEAPAGE = "http://apparmor.net/"
SECTION = "admin"

LICENSE = "GPL-2.0-only & GPL-2.0-or-later & BSD-3-Clause & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fd57a4b0bc782d7b80fd431f10bbf9d0"

DEPENDS = "bison-native apr gettext-native coreutils-native linux-libc-headers"

SRC_URI = " \
    git://gitlab.com/apparmor/apparmor.git;protocol=https;branch=apparmor-2.13 \
    file://crosscompile_perl_bindings.patch \
    file://apparmor.rc \
    file://functions \
    file://apparmor \
    file://apparmor.service \
    file://0001-Makefile.am-suppress-perllocal.pod.patch \
    file://run-ptest \
"

SRCREV = "b1d7dcab241f35e54ae6a32649eae51cf04553f3"
S = "${WORKDIR}/git"

PARALLEL_MAKE = ""

COMPATIBLE_MACHINE:mips64 = "(!.*mips64).*"

inherit pkgconfig autotools-brokensep update-rc.d python3native perlnative ptest cpan manpages systemd features_check
REQUIRED_DISTRO_FEATURES = "apparmor"

#Enabling python for Apparmor debug builds.
#PACKAGECONFIG ??= "python perl aa-decode"
PACKAGECONFIG[manpages] = "--enable-man-pages, --disable-man-pages"
PACKAGECONFIG[python] = "--with-python, --without-python, python3 swig-native"
PACKAGECONFIG[perl] = "--with-perl, --without-perl, perl perl-native swig-native"
PACKAGECONFIG[apache2] = ",,apache2,"
PACKAGECONFIG[aa-decode] = ",,,bash"

PAMLIB="${@bb.utils.contains('DISTRO_FEATURES', 'pam', '1', '0', d)}"
HTTPD="${@bb.utils.contains('PACKAGECONFIG', 'apache2', '1', '0', d)}"

python() {
    if 'apache2' in d.getVar('PACKAGECONFIG').split() and \
            'webserver' not in d.getVar('BBFILE_COLLECTIONS').split():
        raise bb.parse.SkipRecipe('Requires meta-webserver to be present.')
}

DISABLE_STATIC = ""

do_configure() {
    cd ${S}/libraries/libapparmor
    aclocal
    autoconf --force
    libtoolize --automake -c --force
    automake -ac
    ./configure ${CONFIGUREOPTS} ${EXTRA_OECONF}
}
_CAP_HDR_REGEX = "s/^\#define[ \t]+CAP_([A-Z0-9_]+)[ \t]+([0-9xa-f]+)(.*)/CAP_\1/p" 
_CAP_PP_REGEX = "s/[ \\t]\\?CAP_\\([A-Z1-9_]\\+\\)/\{\"\\L\\1\", \\UCAP_\\1\},\\n/pg"

do_compile () {
    # Fixes:
    # | sed -ie 's///g' Makefile.perl
    # | sed: -e expression #1, char 0: no previous regular expression
    #| Makefile:478: recipe for target 'Makefile.perl' failed
    sed -i "s@sed -ie 's///g' Makefile.perl@@" ${S}/libraries/libapparmor/swig/perl/Makefile


    oe_runmake -C ${B}/libraries/libapparmor
    oe_runmake -C ${B}/binutils
    if ${@bb.utils.contains('PACKAGECONFIG','python','true','false', d)}; then
       oe_runmake -C ${B}/utils
    fi


    oe_runmake -C ${B}/parser cap_names.h

    echo "#include \"${STAGING_DIR_TARGET}/usr/include/linux/capability.h\"" | cpp -dM -E | LC_ALL=C sed -r -n -e "/CAP_EMPTY_SET/d" -e "${_CAP_HDR_REGEX}" | LC_ALL=C sed -n -e "${_CAP_PP_REGEX}" > ${B}/parser/cap_names.h


    oe_runmake -C ${B}/parser
    oe_runmake -C ${B}/profiles

    if test -z "${HTTPD}" ; then
        oe_runmake -C ${B}/changehat/mod_apparmor
    fi

    if test -z "${PAMLIB}" ; then
        oe_runmake -C ${B}/changehat/pam_apparmor
    fi
}

do_install () {
    install -d ${D}/${INIT_D_DIR}
    install -d ${D}/lib/apparmor
    oe_runmake -C ${B}/libraries/libapparmor DESTDIR="${D}" install
    oe_runmake -C ${B}/binutils DESTDIR="${D}" install
    if ${@bb.utils.contains('PACKAGECONFIG','python','true','false', d)}; then
       oe_runmake -C ${B}/utils DESTDIR="${D}" install
    fi
    oe_runmake -C ${B}/parser DESTDIR="${D}" install
    if ${@bb.utils.contains('PACKAGECONFIG','python','true','false', d)}; then
       oe_runmake -C ${B}/profiles DESTDIR="${D}" install
    fi

    # If perl is disabled this script won't be any good
    if ! ${@bb.utils.contains('PACKAGECONFIG','perl','true','false', d)}; then
        rm -f ${D}${sbindir}/aa-notify
    fi

    if ! ${@bb.utils.contains('PACKAGECONFIG','aa-decode','true','false', d)}; then
        rm -f ${D}${sbindir}/aa-decode
    fi

    if test -z "${HTTPD}" ; then
        oe_runmake -C ${B}/changehat/mod_apparmor DESTDIR="${D}" install
    fi

    if test -z "${PAMLIB}" ; then
        oe_runmake -C ${B}/changehat/pam_apparmor DESTDIR="${D}" install
    fi

    # aa-easyprof is installed by python-tools-setup.py, fix it up
    # sed -i -e 's:/usr/bin/env.*:/usr/bin/python3:' ${D}${bindir}/aa-easyprof
    # chmod 0755 ${D}${bindir}/aa-easyprof

    install ${WORKDIR}/apparmor ${D}/${INIT_D_DIR}/apparmor
    install ${WORKDIR}/functions ${D}/lib/apparmor
    sed -i -e 's/getconf _NPROCESSORS_ONLN/nproc/' ${D}/lib/apparmor/functions
    sed -i -e 's/ls -AU/ls -A/' ${D}/lib/apparmor/functions

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/apparmor.service ${D}${systemd_system_unitdir}
    fi
}

#Building ptest on arm fails.
do_compile_ptest:aarch64 () {
  :
}

do_compile_ptest:arm () {
  :
}

do_compile_ptest () {
    sed -i -e 's/cpp \-dM/${HOST_PREFIX}gcc \-dM/' ${B}/tests/regression/apparmor/Makefile
    oe_runmake -C ${B}/tests/regression/apparmor
    oe_runmake -C ${B}/libraries/libapparmor
}

do_install_ptest () {
    t=${D}/${PTEST_PATH}/testsuite
    install -d ${t}
    install -d ${t}/tests/regression/apparmor
    cp -rf ${B}/tests/regression/apparmor ${t}/tests/regression

    cp ${B}/parser/apparmor_parser ${t}/parser
    cp ${B}/parser/frob_slack_rc ${t}/parser

    install -d ${t}/libraries/libapparmor
    cp -rf ${B}/libraries/libapparmor ${t}/libraries

    install -d ${t}/common
    cp -rf ${B}/common ${t}

    install -d ${t}/binutils
    cp -rf ${B}/binutils ${t}
}

#Building ptest on arm fails.
do_install_ptest:aarch64 () {
  :
}

do_install_ptest:arm() {
  :
}

#pkg_postinst_ontarget:${PN} () {
#if [ ! -d /etc/apparmor.d/cache ] ; then
#    mkdir /etc/apparmor.d/cache
#fi
#}

# We need the init script so don't rm it
RMINITDIR:class-target:remove = " rm_sysvinit_initddir"

INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME = "apparmor"
INITSCRIPT_PARAMS = "start 16 2 3 4 5 . stop 35 0 1 6 ."

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "apparmor.service"
SYSTEMD_AUTO_ENABLE ?= "enable"

PACKAGES += "mod-${PN}"

FILES:${PN} += "/lib/apparmor/  ${systemd_system_unitdir} ${sysconfdir}/apparmor ${PYTHON_SITEPACKAGES_DIR}"
FILES:mod-${PN} = "${libdir}/apache2/modules/*"

# Add coreutils and findutils only if sysvinit scripts are in use
RDEPENDS:${PN} +=  "${@["coreutils findutils", ""][(d.getVar('VIRTUAL-RUNTIME_init_manager') == 'systemd')]} ${@bb.utils.contains('PACKAGECONFIG','python','python3-core python3-modules','', d)}"
RDEPENDS:${PN}:remove += "${@bb.utils.contains('PACKAGECONFIG','perl','','perl', d)}"
RDEPENDS:${PN}-ptest += "perl coreutils dbus-lib bash"

PRIVATE_LIBS:${PN}-ptest = "libapparmor.so*"
LDFLAGS:remove = "-flto"
CFLAGS:remove = "-flto"
CXXFLAGS:remove = "-flto"
