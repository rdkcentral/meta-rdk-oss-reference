#
# Based on breakpad_2023.06.01.bb https://github.com/rdkcentral/meta-rdk-oss-reference, scarthgap branch, July 24, 2026
#
include 2023.06.01/breakpad_2023.06.01.inc
FILESEXTRAPATHS:prepend := "${THISDIR}/2023.06.01/breakpad:"

# The latest rev without C++20 dep
SRCREV_breakpad = "2c736308b5a4c7a8371fa3a3e434f551eddd17c9"
SRC_URI:remove = "file://0001-Fixed-missing-include-for-std-find_if.patch"
# Fix off_t type size difference across API boundary
SRC_URI  += "file://breakpad-stable-size_limit-abi-int64.patch"


SRC_URI += "file://breakpad_disable_format_macros_check.patch "
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
