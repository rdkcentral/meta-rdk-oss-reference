FILESEXTRAPATHS:prepend := "${THISDIR}/${BP}:"
SRC_URI += "file://CVE-2016-7543.patch \
            file://CVE-2016-9401.patch \
            file://CVE-2019-9924.patch \
            file://CVE-2019-18276.patch \
"

# GCC 15 C99 strict-prototype fix: general.h declares list_reverse() with no params (K&R),
# but calls it with one argument. GCC 15 treats void foo() as "no arguments" in C99 mode.
# -std=gnu89 restores K&R semantics. Proper upstream fix: add typed prototype in general.h.
CFLAGS:append:wrynose = " -std=gnu89"

# OE6 [buildpaths]: bash_3.2.57/bash.inc (meta-rdk-oss-reference/recipes-gplv2) predates the
# fix_absolute_paths() function added in upstream OE-core bash.inc for bash 5.x. It only strips
# --sysroot and -I${WORKDIR} from bashbug, missing -ffile-prefix-map= entries that OE6
# bitbake.conf injects into CFLAGS (these embed TMPDIR paths, caught by [buildpaths]).
# Kirkstone bash 3.2.57: -ffile-prefix-map= was not injected into CFLAGS then, no error.
# Note: the upstream 's|${DEBUG_PREFIX_MAP}||g' does not work because DEBUG_PREFIX_MAP uses
# -fdebug-prefix-map= but OE6 wrynose emits -ffile-prefix-map=.
# Using :wrynose only (not :class-target:wrynose) — 3-level compound overrides on functions
# are silently dropped; :class-target is redundant since wrynose is target-only.
do_install:append:wrynose() {
    if [ -f "${D}${bindir}/bashbug" ]; then
        # Strip all -f*-prefix-map= flags (all forms: -ffile-prefix-map=, -fcanon-prefix-map, etc.)
        sed -i -e 's| -f[a-z-]*prefix-map[^ ]*||g' \
               -e "s,${BASE_WORKDIR},,g" \
            "${D}${bindir}/bashbug"
    fi
    if [ -f "${D}${libdir}/pkgconfig/bash.pc" ]; then
        sed -i -e "s,--sysroot=${STAGING_DIR_TARGET},,g" \
            "${D}${libdir}/pkgconfig/bash.pc"
    fi
    if [ -f "${D}${libdir}/bash/Makefile.inc" ]; then
        sed -i -e "s,--sysroot=${STAGING_DIR_TARGET},,g" \
               -e 's:${HOSTTOOLS_DIR}/::g' \
               -e "s,${BASE_WORKDIR},,g" \
            "${D}${libdir}/bash/Makefile.inc"
    fi
}

# [build-deps] bash → base-files: runtime dep (/etc/shells registration), not a build dep.
# [build-deps] bash-ptest → make: runtime dep for running test suite, not a build dep.
INSANE_SKIP:${PN}:append:wrynose = " build-deps"
INSANE_SKIP:${PN}-ptest:append:wrynose = " build-deps"
