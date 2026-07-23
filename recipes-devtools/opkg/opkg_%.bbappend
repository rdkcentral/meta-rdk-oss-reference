FILESEXTRAPATHS:prepend := "${THISDIR}/opkg:"

SRC_URI:append:class-target = " \
           file://0001-package_name_code_path_crash_fix.patch \
           file://0002-fix_crash_when_opkg_does_reinit.patch \
"

SRC_URI:append = " file://multi_thread_installer.patch"

# wrynose OE6: pseudo intercepts mkdir but doesn't create dir on disk → ENOENT in finalize_intercepts
SRC_URI:append = " file://0003-fix-opkg-intercept-enoent.patch"

# libsolv is not compatible with libopkg-api in v0.4.2
EXTRA_OECONF:remove:class-target = "--with-libsolv"

