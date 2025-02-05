FILESEXTRAPATHS:prepend := "${THISDIR}/opkg:"

SRC_URI:append:class-target = " \
           file://0001-package_name_code_path_crash_fix.patch \
           file://0002-fix_crash_when_opkg_does_reinit.patch \
           file://0005-update-pkg-filename-in-callback.patch \
"


SRC_URI:append:class-target = " file://0005-support_for_kirkstone_opkg_fix.patch "

SRC_URI:append = " file://multi_thread_installer.patch"

# libsolv is not compatible with libopkg-api in v0.4.2
EXTRA_OECONF:remove:class-target = "--with-libsolv"

