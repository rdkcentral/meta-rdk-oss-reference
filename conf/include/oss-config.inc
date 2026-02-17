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

INCOMPATIBLE_LICENSE = "LGPL-3.0-or-later LGPL-3.0-only GPL-3.0-or-later GPL-3.0-only"
require license_flags_accepted.inc

#Use or Enable following distro feature if you want to enable gplv3 components such as tar, gdb which are used for debugging purpose
#DISTRO_FEATURES:append = " build_gplv3"
#Fix RDK-48310 & RDK-48267
INCOMPATIBLE_LICENSE_EXCEPTIONS += "${@bb.utils.contains('DISTRO_FEATURES','build_gplv3', '${MLPREFIX}tar:GPL-3.0-only ${MLPREFIX}gdbserver:GPL-3.0-only ${MLPREFIX}gdbserver:LGPL-3.0-only ${MLPREFIX}gdb:GPL-3.0-only ${MLPREFIX} gdb:LGPL-3.0-only ${MLPREFIX}binutils:GPL-3.0-only ${MLPREFIX}libbfd:GPL-3.0-only', '', d)}"

require package_revisions_oss.inc
BBMASK .= "|${RDKROOT}/rdke/common/meta-rdk-oss-reference/recipes-connectivity/bluez5/bluez5_5.77*"

# Global: Enable ptest framework for all packages
PTEST_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' 1', '', d)}"

# Image content: What to include in the image (when ptest enabled)
EXTRA_IMAGE_FEATURES:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' ptest-pkgs', '', d)}"
IMAGE_INSTALL:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' gdbm-ptest pango-ptest bluez5 findutils-ptest', '', d)}"

# License policy: What licenses are acceptable in this build
LICENSE_FLAGS_ACCEPTED:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' GPL-3.0-only GPL-3.0-or-later', '', d)}"
INCOMPATIBLE_LICENSE:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' GPL-3.0-only LGPL-3.0-only LGPL-3.0-or-later GPL-3.0-or-later', '', d)}"

# Version preferences: May go to distro config or local.conf
PREFERRED_VERSION_libarchive = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' 3.6.2', '', d)}"
PREFERRED_VERSION_gmp = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' 6.2.1', '', d)}"
PREFERRED_VERSION_m4 = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' 1.4.19', '', d)}"
PREFERRED_VERSION_coreutils = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' 9.0', '', d)}"

BBMASK:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' meta-rdk-oss-reference/recipes-gplv2/gettext/gettext_0.16.1.bb ', '', d)}"




