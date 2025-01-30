
PACKAGECONFIG +=  "${@bb.utils.contains('DISTRO_FEATURES', 'gdb-readline', ' readline ', '', d)}"

# From meta-rdk-comcast/recipes-devtools/gdb/gdb_%.bbappend
DOWNLOAD_APPS="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','debug_tools-gdb',' ',d)}"
INHERIT_COMCAST_PACKAGE_DEPLOY := "${@bb.utils.contains('DISTRO_FEATURES', 'debugtools_rdm', 'comcast-package-deploy', '', d)}"
inherit ${INHERIT_COMCAST_PACKAGE_DEPLOY}
DOWNLOAD_ON_DEMAND="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','yes',' ',d)}"
DOWNLOAD_METHOD_CONTROLLER="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','RFC',' ',d)}"
