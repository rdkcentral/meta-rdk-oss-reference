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

DISTRO_FEATURES:append = " ptest "
EXTRA_IMAGE_FEATURES += "ptest-pkgs"
#IMAGE_INSTALL:remove = "diffutils-ptest gawk-ptest gdbm-ptest gettext-ptest gzip-ptest m4-ptest openssl-ptest parted-ptest sed-ptest bluez5-ptest busybox-ptest coreutils-ptest findutils-ptest elfutils-ptest  quilt-ptest e2fsprogs-ptest lttng-tools-ptest strace-ptest apr-util-ptest apr-ptest valgrind-ptest  pango-ptest "
IMAGE_INSTALL:remove = "gdbm-ptest pango-ptest bluez5-ptest findutils-ptest"
LICENSE_FLAGS_ACCEPTED += "GPL-3.0-only"
LICENSE_FLAGS_ACCEPTED += "GPL-3.0-or-later"
PREFERRED_VERSION_libarchive = "3.6.2"
PREFERRED_VERSION_gmp = "6.2.1"
PREFERRED_VERSION_m4 = "1.4.19"
PREFERRED_VERSION_coreutils = "9.0"
INCOMPATIBLE_LICENSE:remove = " GPL-3.0-only LGPL-3.0-only LGPL-3.0-or-later  GPL-3.0-or-later"
RDEPENDS:remove:pn-core-image-ptest = "diffutils-ptest"
INSANE_SKIP:pn-zlib = "ldflags"
BBMASK:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' meta-rdk-oss-reference/recipes-gplv2/gettext/gettext_0.16.1.bb ', '', d)}"



