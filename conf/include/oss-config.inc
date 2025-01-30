CMF_GIT_ROOT ?= "git://code.rdkcentral.com/r"
CMF_GIT_PROTOCOL ?= "https"
CMF_GIT_MASTER_BRANCH ?= "master"

CMF_GITHUB_ROOT ?= "git://github.com/rdkcentral"
CMF_GITHUB_PROTOCOL = "https"
CMF_GITHUB_BRANCH = "nobranch=1"
CMF_GITHUB_SRC_URI_SUFFIX = "protocol=${CMF_GITHUB_PROTOCOL};${CMF_GITHUB_BRANCH}"
CMF_GITHUB_MAIN_BRANCH ?= "main"
CMF_GITHUB_MASTER_BRANCH ?= "master"
CMF_GITHUB_STABLE2_BRANCH ?= "stable2"

RDKE_GITHUB_ROOT ?= "git://git@github.com/rdk-e"
RDKE_GITHUB_PROTOCOL ?= "ssh"
RDKE_GITHUB_BRANCH ?= "nobranch=1"
RDKE_GITHUB_SRC_URI_SUFFIX ?= "protocol=${RDKE_GITHUB_PROTOCOL};${RDKE_GITHUB_BRANCH}"


INCOMPATIBLE_LICENSE = "GPLv3.0 GPLv3 GPL-3.0 GPLv3+ LGPLv3.0 LGPLv3 LGPL-3.0 LGPLv3+"
require license_flags_whitelist.inc
#Use or Enable following distro feature if you want to enable gplv3 components such as readline-native, gdb, binutils and libbfd which are used for debugging purpose
#DISTRO_FEATURES:append = " build_gplv3"
#Present in rdk.conf
WHITELIST_GPLv3 += "${@bb.utils.contains('DISTRO_FEATURES','build_gplv3','${MLPREFIX}tar ${MLPREFIX}gdbserver ${MLPREFIX}gdb ${MLPREFIX}binutils ${MLPREFIX}libbfd','',d)}"

require package_revisions_oss.inc
BBMASK .= "|${RDKROOT}/rdke/common/meta-rdk-oss-reference/recipes-connectivity/bluez5/bluez5_5.77*"


