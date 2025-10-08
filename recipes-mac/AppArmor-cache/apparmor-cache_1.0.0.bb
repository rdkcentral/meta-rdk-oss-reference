SUMMARY = "AppArmor systemd Service File Creation"
DESCRIPTION = "Builds native apparmor_parser, then compiles and installs per service profiles"
HOMEAPAGE = "http://apparmor.net/"
SECTION = "admin"

LICENSE = "GPLv2 & GPLv2+ & BSD-3-Clause & LGPLv2.1+"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fd57a4b0bc782d7b80fd431f10bbf9d0"

DEPENDS = "bison-native apr-native gettext-native coreutils-native python3-native" 
DEPENDS:append:class-target = " apparmor-cache-native" 

inherit pkgconfig autotools autotools-brokensep python3native perlnative cpan features_check python3native

SRC_URI = " \
    git://gitlab.com/apparmor/apparmor.git;protocol=https;branch=apparmor-2.13 \
    file://features	\
    file://serviceprofile_parse/parse.py   \
"

#
# This recipe works in conjunction with image recipes to build service profiles. This is a two part
# process:
#
#	1. This recipe - builds native apparmor_parser and relevant libraries, obtains and runs the
#		service profile syntax parser and generates profiles for those specified in a
#		device "bundle" (see docs on serviceprofile_parse/), then dumps those into 
#		rootfs/etc/apparmor/aa_profiles/ for parsing later
#
#	2. The image recipe - The image recipe must iterate over every service file on the device
#		then add an AppArmorProfile= entry for the service profile name, then check if
#		a service profile already exists from step #1. If it doesn't then create one using
#		the default structure. Finally, put these profiles in rootfs/etc/apparmor/aa_profiles/ and
#		then compile them to /etc/apparmor/earlypolicy/
#
# This recipe and the image recipe must work in conjunction to ensure full coverage. 

SRCREV = "b1d7dcab241f35e54ae6a32649eae51cf04553f3"
S = "${WORKDIR}/git"
PARALLEL_MAKE = ""
DISABLE_STATIC = ""

do_configure:class-target () { 
	: 
}

do_compile:class-target () { 
	: 
}

do_configure:class-native () {
    cd ${S}/libraries/libapparmor
    aclocal
    autoconf --force
    libtoolize --automake -c --force
    automake -ac
    ./configure ${CONFIGUREOPTS} ${EXTRA_OECONF}
}

_CAP_HDR_REGEX = "s/^\#define[ \t]+CAP_([A-Z0-9_]+)[ \t]+([0-9xa-f]+)(.*)/CAP_\1/p" 
_CAP_PP_REGEX = "s/[ \\t]\\?CAP_\\([A-Z1-9_]\\+\\)/\{\"\\L\\1\", \\UCAP_\\1\},\\n/pg"
do_compile:class-native () {
    sed -i "s@sed -ie 's///g' Makefile.perl@@" ${S}/libraries/libapparmor/swig/perl/Makefile
    oe_runmake -C ${B}/libraries/libapparmor
    oe_runmake -C ${B}/binutils
    oe_runmake -C ${B}/parser cap_names.h
    echo "#include \"${STAGING_DIR_NATIVE}/usr/include/linux/capability.h\"" | cpp -dM -E | LC_ALL=C sed -r -n -e "/CAP_EMPTY_SET/d" -e "${_CAP_HDR_REGEX}" | LC_ALL=C sed -n -e "${_CAP_PP_REGEX}" > ${B}/parser/cap_names.h
    oe_runmake -C ${B}/parser
    oe_runmake -C ${B}/profiles
}

do_install:class-native () {
    install -d ${D}${libdir}/apparmor
    install -d ${D}${base_sbindir}
    install -d ${D}/etc/aaprofiles/ 
    oe_runmake -C ${B}/libraries/libapparmor DESTDIR="${D}" install
    oe_runmake -C ${B}/binutils DESTDIR="${D}" install
    oe_runmake -C ${B}/parser DESTDIR="${D}" install
    install -d ${WORKDIR}/tmp_cache/

    cp -r ${S}/parser/apparmor_parser ${D}${base_sbindir}/apparmor_parser

    install -d ${D}${libdir}/apparmor_cache
    install -m 0755 ${WORKDIR}/features ${D}${libdir}/features
}

EXTRANATIVEPATH = "apparmor-cache-native"
LDFLAGS:remove = "-flto"
CFLAGS:remove = "-flto"
CXXFLAGS:remove = "-flto"
FILES:${PN} += "/etc/apparmor/earlypolicy/*"
FILES:${PN} += "/etc/apparmor/aa_profiles/"

FILES:${PN}-native += "${base_sbindir}/apparmor_parser"
FILES:${PN}-dbg += "${base_sbindir}/apparmor_parser"
FILES:${PN}-native += "${libdir}/features"
BBCLASSEXTEND = "native"
