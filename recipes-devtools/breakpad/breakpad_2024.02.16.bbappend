FILESEXTRAPATHS:prepend := "${THISDIR}/files-2024.02.16:"

# Disable the inttypes.h format-macro guard that fires on some toolchains
SRC_URI:append = " file://breakpad_disable_format_macros_check.patch"

# Comcast: revert DT_SONAME-as-module-name change (regressed RDK BT extraction tooling)
SRC_URI:append = " file://Set-objects-base-name-as-a-module-name.patch"

# Comcast: receiver logging hooks + ReceiverBreakpadLogging flag in ExceptionHandler
SRC_URI:append = " file://0001_google-breakpad_comcast_dunfell.patch"

# Comcast: prepend /proc/pid/comm to minidump filename; also implements BREAKPAD_GUID
# env override (supersedes the old custom-minidump-id.patch)
SRC_URI:append = " file://breakpad2_1-processname.patch"

# Comcast: WKIT-843 — child process read-hang fix (not needed for native/nativesdk builds)
SRC_URI:append:class-target = " file://0003-handler-child-process-hang-fix_kirkstone.patch"

# Comcast: filter PT_NOTE segments by NT_GNU_BUILD_ID type — irrelevant on big-endian
SRC_URI += "${@bb.utils.contains('TUNE_FEATURES','bigendian','','file://multi-node-header-check-for-build-id_dunfell.patch',d)}"


PACKAGES =+ "${PN}-stackwalk ${PN}-binaries"

# uncomment this line to get minidump_stackwalk in the image
# RDEPENDS:breakpad += "${PN}-stackwalk"

FILES:${PN}-stackwalk = "${bindir}/minidump_stackwalk"
FILES:${PN}-binaries = "${bindir}/*"

RDEPENDS:${PN}-dev = ""
RDEPENDS:${PN}-staticdev = ""

BBCLASSEXTEND:append = " nativesdk"
