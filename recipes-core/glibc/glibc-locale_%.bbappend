# Add MLPREFIX to support oss arch with multilib support
LOCALETREESRC = "${COMPONENTS_DIR}/${PACKAGE_ARCH}/${MLPREFIX}glibc-stash-locale"

# Enable if ptest is built
ENABLE_BINARY_LOCALE_GENERATION = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '1', '0', d)}"
#To avoid do_package_qa issue for files not shipped but installed.
do_install_append() {
        # Remove empty dirs in libdir when gconv or locales are not copied
        find ${D}${libdir} -type d -empty -delete
}

