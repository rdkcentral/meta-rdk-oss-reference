FILESEXTRAPATHS_prepend := "${THISDIR}/opkg:"

SRC_URI_append_class-target = " \
           file://0001-package_name_code_path_crash_fix.patch \
           file://0002-fix_crash_when_opkg_does_reinit.patch \
           file://0005-update-pkg-filename-in-callback.patch \
"

SRC_URI_append_class-target_dunfell = " file://0004-support_for_dunfell_opkg_fix.patch "

# libsolv is not compatible with libopkg-api in v0.4.2
EXTRA_OECONF_remove_class-target = "--with-libsolv"
EXTRA_OECONF_append_class-target_morty = " --with-libsolv"
