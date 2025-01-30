
TUNE_CCARGS:append:krogoth = " -fomit-frame-pointer"

# Fix for RDK-48882
do_stash_locale[sstate-outputdirs] = "${COMPONENTS_DIR}/${PACKAGE_ARCH}/${MLPREFIX}glibc-stash-locale"
do_stash_locale[sstate-fixmedir] = "${COMPONENTS_DIR}/${PACKAGE_ARCH}/${MLPREFIX}glibc-stash-locale"
