DOWNLOAD_APPS="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','debug_tools-strace',' ',d)}"
INHERIT_COMCAST_PACKAGE_DEPLOY := "${@bb.utils.contains('DISTRO_FEATURES', 'debugtools_rdm', 'comcast-package-deploy', '', d)}"
inherit ${INHERIT_COMCAST_PACKAGE_DEPLOY}
DOWNLOAD_ON_DEMAND="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','yes',' ',d)}"
DOWNLOAD_METHOD_CONTROLLER="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','RFC',' ',d)}"
