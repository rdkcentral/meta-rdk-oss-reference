
TUNE_CCARGS:append:krogoth = " -fomit-frame-pointer"
OLDEST_KERNEL:pn-glibc = "5.4"

CFLAGS:remove = "\${DEBUG_FLAGS}"
CXXFLAGS:remove = "\${DEBUG_FLAGS}"

do_configure:prepend() {
	CFLAGS=$(printf '%s\n' "${CFLAGS}" | sed 's/\${DEBUG_FLAGS}//g')
	CXXFLAGS=$(printf '%s\n' "${CXXFLAGS}" | sed 's/\${DEBUG_FLAGS}//g')
	sed -i 's/GLIBC_AUTOCONF_VERSION\], \[2.72\]/GLIBC_AUTOCONF_VERSION], [2.73]/' ${S}/aclocal.m4
}

# Fix for RDK-48882
do_stash_locale[sstate-outputdirs] = "${COMPONENTS_DIR}/${PACKAGE_ARCH}/${MLPREFIX}glibc-stash-locale"
do_stash_locale[sstate-fixmedir] = "${COMPONENTS_DIR}/${PACKAGE_ARCH}/${MLPREFIX}glibc-stash-locale"
