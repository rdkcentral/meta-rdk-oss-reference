FILESEXTRAPATHS:prepend := "${THISDIR}/files-2024.02.16:"

SRC_URI:append = " file://breakpad_disable_format_macros_check.patch "

SRC_URI += "file://Set-objects-base-name-as-a-module-name.patch"

# TODO : check if still needed. It provides new APIs so drop if all builds pass
#SRC_URI += "file://0001_google-breakpad_comcast_dunfell.patch "

SRC_URI:append:class-target = " file://0003-handler-child-process-hang-fix_kirkstone.patch"

SRC_URI += "${@bb.utils.contains('TUNE_FEATURES','bigendian','','file://multi-node-header-check-for-build-id_dunfell.patch',d)}"

SRC_URI += "file://custom-minidump-id.patch"
SRC_URI += "file://breakpad2_1-processname.patch"

PACKAGES =+ "${PN}-stackwalk ${PN}-binaries"

# uncomment this line to get minidump_stackwalk in the image
# RDEPENDS:breakpad += "${PN}-stackwalk"

FILES:${PN}-stackwalk = "${bindir}/minidump_stackwalk"
FILES:${PN}-binaries = "${bindir}/*"

RDEPENDS:${PN}-dev = ""
RDEPENDS:${PN}-staticdev = ""

BBCLASSEXTEND:append = " nativesdk"
