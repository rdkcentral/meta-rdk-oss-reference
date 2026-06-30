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
# ptest disabled — no GPL-3.0 ptest-tool exceptions needed
DISTRO_FEATURES:remove = "ptest"

require license_flags_accepted.inc

#Use or Enable following distro feature if you want to enable gplv3 components such as tar, gdb which are used for debugging purpose
#DISTRO_FEATURES:append = " build_gplv3"
#Fix RDK-48310 & RDK-48267
INCOMPATIBLE_LICENSE_EXCEPTIONS += "${@bb.utils.contains('DISTRO_FEATURES','build_gplv3', '${MLPREFIX}tar:GPL-3.0-only ${MLPREFIX}gdbserver:GPL-3.0-only ${MLPREFIX}gdbserver:LGPL-3.0-only ${MLPREFIX}gdb:GPL-3.0-only ${MLPREFIX} gdb:LGPL-3.0-only ${MLPREFIX}binutils:GPL-3.0-only ${MLPREFIX}libbfd:GPL-3.0-only', '', d)}"

# Prefer newer upstream versions over old pinned RDK recipes
PREFERRED_VERSION_glib-2.0 = "2.88.0"
PREFERRED_VERSION_glib-2.0-native = "2.88.0"
PREFERRED_VERSION_systemd = "259.5"

# wrynose-058/091: pin gdbm-native to 1.26 — fixes python3-native _dbm undefined symbol
PREFERRED_VERSION_gdbm-native:wrynose = "1.26"
PREFERRED_VERSION_gdbm:wrynose = "1.26"

# wrynose-059: pin readline-native to 8.3 — avoids GNU-fetched patches
PREFERRED_VERSION_readline-native:wrynose = "8.3"

# wrynose-084: pin gettext-native to 1.x — shared-mime-info needs msgfmt >=0.19.7
PREFERRED_VERSION_gettext-native:wrynose = "1.%"

# wrynose-086: pin nlohmann-json to 3.12.x — CMake 4.x compatibility
PREFERRED_VERSION_nlohmann-json:wrynose = "3.12.%"

# wrynose-137: GPL-2.0 replacements for recipes excluded by INCOMPATIBLE_LICENSE
PREFERRED_VERSION_findutils:wrynose = "4.2.31"
PREFERRED_VERSION_gawk:wrynose = "3.1.5"

# wrynose-180: pin tar-native to 1.35 — OE6 do_image_tar --sort=name support
PREFERRED_VERSION_tar-native:wrynose = "1.35"

# OE6 promoted patch-fuzz from WARNING to ERROR; downgrade globally for migration
ERROR_QA:remove = "patch-fuzz"
WARN_QA:append = " patch-fuzz"
# OE6 promoted incompatible-license from WARNING to ERROR; downgrade for migration
# (license exclusion still occurs correctly, only the notification level changes)
ERROR_QA:remove = "incompatible-license"
WARN_QA:append = " incompatible-license"

# glslang 1.4.341.0 requires spirv-tools 1.4.341.0 — pin to OE-core version
# spirv-headers must match spirv-tools exactly (vkspreflection grammar added in 1.4.341.0)
PREFERRED_VERSION_spirv-tools = "1.4.341.0"
PREFERRED_VERSION_spirv-tools-native = "1.4.341.0"
PREFERRED_VERSION_spirv-headers = "1.4.341.0"
PREFERRED_VERSION_spirv-headers-native = "1.4.341.0"
# glibc 2.43 requires kernel headers >= 5.15 (OLDEST_KERNEL=5.15 in bitbake.conf)
# meta-rdk-oss-reference ships only 5.4/4.9; use OE-core 6.18 headers instead
PREFERRED_VERSION_linux-libc-headers = "6.18"

# wrynose/gcc-15: rdke-config.inc removes -Wformat/-Wformat-security from SECURITY_CFLAGS
# but leaves -Werror=format-security, which GCC 15 rejects without -Wformat. Remove globally.
SECURITY_CFLAGS:remove:wrynose = "-Werror=format-security"
# Keep per-recipe overrides for libgcc/libgcc-initial (needed for SECURITY_STRINGFORMAT too)
SECURITY_STRINGFORMAT:pn-libgcc-initial = ""
SECURITY_STRINGFORMAT:pn-libgcc = ""

# wrynose: zlib 1.2.11's gzguts.h undefines _FILE_OFFSET_BITS when _LARGEFILE64_SOURCE
# is set, which breaks glibc 2.43's _TIME_BITS=64 check. Use OE-core 1.3.2 instead.
# (CVE-2018-25032/CVE-2022-37434/CVE-2023-45853 are all fixed in 1.3.x upstream)
PREFERRED_VERSION_zlib:wrynose = "1.3.2"

# wrynose: mesa 26.0.5 requires libdrm >= 2.4.109; package_revisions_oss.inc pins 2.4.100.
# Use OE-core's 2.4.131 instead.
PREFERRED_VERSION_libdrm:wrynose = "2.4.131"
PREFERRED_VERSION_nativesdk-libdrm:wrynose = "2.4.131"
# wrynose: gupnp 0.20.10 requires gssdp-1.2 but OE6 only has gssdp-1.6; use gupnp 1.6.x
PREFERRED_VERSION_gupnp = "1.6.%"

require package_revisions_oss.inc
BBMASK .= "|${RDKROOT}/rdke/common/meta-rdk-oss-reference/recipes-connectivity/bluez5/bluez5_5.77*"
# wrynose: gssdp16_1.6.3 conflicts with gssdp_1.6.4 (both install libgssdp-1.6-* packages)
BBMASK .= "|${RDKROOT}/rdke/common/oss/meta-rdk-oss-reference/recipes-connectivity/gupnp/gssdp16_1.6.3.bb"

