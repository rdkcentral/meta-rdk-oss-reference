FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI_append = " file://breakpad_disable_format_macros_check.patch "
SRC_URI_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'mixmode', 'file://breakpad_mixedmode_fpregs_git.patch', '', d)} "

# From meta-rdk-comcast/recipes-devtools/breakpad/breakpad_git.bbappend
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://Set-objects-base-name-as-a-module-name.patch"

# From meta-rdk-comcast/recipes-tweaks/breakpad/breakpad_git.bbappend
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001_google-breakpad_comcast_dunfell.patch "

SRC_URI_append_class-target = " ${@bb.utils.contains('DISTRO_FEATURES','kirkstone','file://0003-handler-child-process-hang-fix_kirkstone.patch','file://0003-handler-child-process-hang-fix_dunfell.patch',d)}"

SRC_URI += "${@bb.utils.contains('TUNE_FEATURES','bigendian','','file://multi-node-header-check-for-build-id_dunfell.patch',d)}"

SRC_URI += "file://custom-minidump-id.patch"
SRC_URI += "file://breakpad2_1-processname.patch"

SRC_URI_append = " file://create_stackwalk_common_target.patch"

PACKAGES =+ "${PN}-stackwalk ${PN}-binaries"

# uncomment this line to get minidump_stackwalk in the image
# RDEPENDS_breakpad += "${PN}-stackwalk"

FILES_${PN}-stackwalk = "${bindir}/minidump_stackwalk"
FILES_${PN}-binaries = "${bindir}/*"

RDEPENDS_${PN}-dev = ""
RDEPENDS_${PN}-staticdev = ""

BBCLASSEXTEND_append = " nativesdk"
