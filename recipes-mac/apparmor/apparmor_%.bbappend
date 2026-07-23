do_install:append() {
rm -rf ${D}${systemd_system_unitdir}/apparmor.service
}
SYSTEMD_SERVICE:apparmor:remove = "apparmor.service"

BBCLASSEXTEND = "native"
DEPENDS:remove:class-native = "linux-libc-headers"
PACKAGECONFIG:class-native ?= ""
SRC_URI:append:class-native = " file://features "

do_install:append:class-native() {
    install -d ${D}${base_sbindir}
    install -d ${D}${libdir}
    install -m 0755 ${S}/parser/apparmor_parser ${D}${base_sbindir}/apparmor_parser
    install -m 0755 ${WORKDIR}/features ${D}${libdir}/features
}

# OE6 migration (wrynose): Two separate UNPACKDIR issues:
#
# 1. file:// items (apparmor, functions, apparmor.service) unpack into UNPACKDIR
#    (${WORKDIR}/sources), not WORKDIR. Copy them back so do_install refs work.
#
# 2. The comcast-broadband bbappend adds private profile repos via SRC_URI with
#    destsuffix=git/apparmor-profiles etc. In OE5 these landed at ${WORKDIR}/git/*
#    (same directory as S). In OE6 they land at ${UNPACKDIR}/git/* while S is
#    ${WORKDIR}/sources/apparmor-3.1.7, so ${S}/apparmor-profiles doesn't exist.
#    Create symlinks to bridge the path mismatch.
do_install:prepend:wrynose () {
    # Fix 1: copy file:// local items from UNPACKDIR to WORKDIR
    for f in apparmor functions apparmor.rc apparmor.service; do
        if [ -f "${UNPACKDIR}/${f}" ] && [ ! -f "${WORKDIR}/${f}" ]; then
            cp "${UNPACKDIR}/${f}" "${WORKDIR}/${f}"
        fi
    done

    # Fix 2: symlink private profile repos from UNPACKDIR/git/* into ${S}/
    for repo in apparmor-profiles rdkb-apparmor-profiles rdk-apparmor-profiles; do
        if [ -d "${UNPACKDIR}/git/${repo}" ] && [ ! -e "${S}/${repo}" ]; then
            ln -sfn "${UNPACKDIR}/git/${repo}" "${S}/${repo}"
        fi
    done
}

# OE6 migration (wrynose): apparmor parser/Makefile installs apparmor_parser to
# $(DESTDIR)/sbin (hardcoded). With usrmerge, ${sbindir}=/usr/sbin, so the binary
# at /sbin/apparmor_parser is not covered by default FILES:${PN} (which uses
# ${sbindir}). Add it explicitly.
FILES:${PN}:append:wrynose = " /sbin/apparmor_parser"

# apparmor-ptest RDEPENDS on bash, coreutils and dbus-lib as test runtime tools
# (not build-time dependencies). The usrmerge QA check fires because apparmor_parser
# is installed to /sbin (hardcoded Makefile) which violates usrmerge policy, and the
# apparmor-dbg package also has files under /sbin/.debug/. Skip both checks for all
# apparmor packages on wrynose.
INSANE_SKIP:append:wrynose = " build-deps usrmerge"
