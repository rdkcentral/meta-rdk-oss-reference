FILESEXTRAPATHS:append := "${THISDIR}/files:"

SRC_URI:append = " file://breakpad_disable_format_macros_check.patch "
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'mixmode', 'file://breakpad_mixedmode_fpregs_git.patch', '', d)} "

# From meta-rdk-comcast/recipes-devtools/breakpad/breakpad_git.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://Set-objects-base-name-as-a-module-name.patch"

# From meta-rdk-comcast/recipes-tweaks/breakpad/breakpad_git.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001_google-breakpad_comcast_dunfell.patch "

SRC_URI:append:class-target = " file://0003-handler-child-process-hang-fix_kirkstone.patch"

SRC_URI += "${@bb.utils.contains('TUNE_FEATURES','bigendian','','file://multi-node-header-check-for-build-id_dunfell.patch',d)}"

SRC_URI += "file://custom-minidump-id.patch"
SRC_URI += "file://breakpad2_1-processname.patch"
SRC_URI += "file://breakpad_allocator_gcc11.patch"

SRC_URI += "file://Add_support_for_compressed_section_to_dump_symbols_kirk.patch"
DEPENDS:append = " zlib elfutils"


PACKAGES =+ "${PN}-stackwalk ${PN}-binaries"

# uncomment this line to get minidump_stackwalk in the image
# RDEPENDS:breakpad += "${PN}-stackwalk"

FILES:${PN}-stackwalk = "${bindir}/minidump_stackwalk"
FILES:${PN}-binaries = "${bindir}/*"

RDEPENDS:${PN}-dev = ""
RDEPENDS:${PN}-staticdev = ""

BBCLASSEXTEND:append = " nativesdk"
