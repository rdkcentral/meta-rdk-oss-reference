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

# Keep excluded subpackages from turning their intentional license exclusions into task failures.
ERROR_QA:remove:pn-libtasn1 = "incompatible-license"
ERROR_QA:remove:pn-mpfr = "incompatible-license"
ERROR_QA:remove:pn-diffutils = "incompatible-license"
ERROR_QA:remove:pn-grep = "incompatible-license"
ERROR_QA:remove:pn-cairo = "incompatible-license"
ERROR_QA:remove:pn-elfutils = "incompatible-license"
ERROR_QA:remove:pn-dejagnu = "incompatible-license"
ERROR_QA:remove:pn-bc = "incompatible-license"
ERROR_QA:remove:pn-libmpc = "incompatible-license"
ERROR_QA:remove:pn-binutils = "incompatible-license"
ERROR_QA:remove:pn-gcc = "incompatible-license"

#Use or Enable following distro feature if you want to enable gplv3 components such as tar, gdb which are used for debugging purpose
#DISTRO_FEATURES:append = " build_gplv3"
#Fix RDK-48310 & RDK-48267
INCOMPATIBLE_LICENSE_EXCEPTIONS += "${@bb.utils.contains('DISTRO_FEATURES','build_gplv3', '${MLPREFIX}tar:GPL-3.0-only ${MLPREFIX}gdbserver:GPL-3.0-only ${MLPREFIX}gdbserver:LGPL-3.0-only ${MLPREFIX}gdb:GPL-3.0-only ${MLPREFIX} gdb:LGPL-3.0-only ${MLPREFIX}binutils:GPL-3.0-only ${MLPREFIX}libbfd:GPL-3.0-only', '', d)}"
INCOMPATIBLE_LICENSE_EXCEPTIONS += "${MLPREFIX}make:GPL-3.0-only ${MLPREFIX}grep:GPL-3.0-only ${MLPREFIX}diffutils:GPL-3.0-or-later ${MLPREFIX}bc:GPL-3.0-or-later ${MLPREFIX}binutils:GPL-3.0-only"
INCOMPATIBLE_LICENSE_EXCEPTIONS += "${MLPREFIX}make-src:GPL-3.0-only \
	${MLPREFIX}make-dbg:GPL-3.0-only ${MLPREFIX}make-ptest:GPL-3.0-only \
	${MLPREFIX}make-staticdev:GPL-3.0-only ${MLPREFIX}make-dev:GPL-3.0-only \
	${MLPREFIX}make-doc:GPL-3.0-only \
	${MLPREFIX}make-locale-be:GPL-3.0-only ${MLPREFIX}make-locale-bg:GPL-3.0-only \
	${MLPREFIX}make-locale-cs:GPL-3.0-only ${MLPREFIX}make-locale-da:GPL-3.0-only \
	${MLPREFIX}make-locale-de:GPL-3.0-only ${MLPREFIX}make-locale-es:GPL-3.0-only \
	${MLPREFIX}make-locale-fi:GPL-3.0-only ${MLPREFIX}make-locale-fr:GPL-3.0-only \
	${MLPREFIX}make-locale-ga:GPL-3.0-only ${MLPREFIX}make-locale-gl:GPL-3.0-only \
	${MLPREFIX}make-locale-he:GPL-3.0-only ${MLPREFIX}make-locale-hr:GPL-3.0-only \
	${MLPREFIX}make-locale-id:GPL-3.0-only ${MLPREFIX}make-locale-it:GPL-3.0-only \
	${MLPREFIX}make-locale-ja:GPL-3.0-only ${MLPREFIX}make-locale-ko:GPL-3.0-only \
	${MLPREFIX}make-locale-lt:GPL-3.0-only ${MLPREFIX}make-locale-nl:GPL-3.0-only \
	${MLPREFIX}make-locale-pl:GPL-3.0-only ${MLPREFIX}make-locale-pt:GPL-3.0-only \
	${MLPREFIX}make-locale-pt-br:GPL-3.0-only ${MLPREFIX}make-locale-ro:GPL-3.0-only \
	${MLPREFIX}make-locale-ru:GPL-3.0-only ${MLPREFIX}make-locale-sr:GPL-3.0-only \
	${MLPREFIX}make-locale-sv:GPL-3.0-only ${MLPREFIX}make-locale-tr:GPL-3.0-only \
	${MLPREFIX}make-locale-uk:GPL-3.0-only ${MLPREFIX}make-locale-vi:GPL-3.0-only \
	${MLPREFIX}make-locale-zh-cn:GPL-3.0-only ${MLPREFIX}make-locale-zh-tw:GPL-3.0-only \
	${MLPREFIX}kbd-src:GPL-3.0-or-later ${MLPREFIX}kbd-dbg:GPL-3.0-or-later \
	${MLPREFIX}kbd-ptest:GPL-3.0-or-later ${MLPREFIX}kbd-staticdev:GPL-3.0-or-later \
	${MLPREFIX}kbd-dev:GPL-3.0-or-later ${MLPREFIX}kbd-doc:GPL-3.0-or-later \
	${MLPREFIX}kbd-locale:GPL-3.0-or-later ${MLPREFIX}kbd-keymaps-pine:GPL-3.0-or-later"

require package_revisions_oss.inc
BBMASK .= "|${RDKROOT}/rdke/common/meta-rdk-oss-reference/recipes-connectivity/bluez5/bluez5_5.77*"
