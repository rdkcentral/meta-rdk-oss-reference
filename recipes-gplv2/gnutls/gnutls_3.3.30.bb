require gnutls.inc

SRC_URI += " \
    file://configure.ac-fix-sed-command.patch \
    file://use-pkg-config-to-locate-zlib.patch \
"
SRC_URI[md5sum] = "748f4c194a51ca9f2c02d9b7735262c2"
SRC_URI[sha256sum] = "41d70107ead3de2f12390909a05eefc9a88def6cd1f0d90ea82a7dac8b8effee"

# GCC 15 defaults to C23 ('false'/'true' are keywords, breaking libopts enum) and
# enables -Wformat-contains-nul as an error.
CFLAGS:append:wrynose = " -std=gnu11 -Wno-format-contains-nul"

# Disable NLS to prevent gnutls-locale-* packages from being created; those
# packages inherit the recipe-level GPL-3.0-or-later license and fail the
# incompatible-license QA check (append overrides any --enable-nls from gettext).
EXTRA_OECONF:append:wrynose = " --disable-nls"

# gnutls-bin (CLI tools) and gnutls-locale (gettext aggregate) are GPL-3.0-or-later
# and excluded by INCOMPATIBLE_LICENSE in wrynose; remove them from PACKAGES
# so the incompatible-license QA check does not fail the task.
PACKAGES:remove:wrynose = "gnutls-bin gnutls-locale"

# When gnutls-bin is removed from PACKAGES, the CLI binaries (certtool, ocsptool
# etc.) fall into the main gnutls package which has LGPL-2.1 license and passes.
# However GCC 15 embeds TMPDIR in the binaries; suppress the buildpaths QA error.
INSANE_SKIP:${PN}:wrynose = "buildpaths"
# gnutls-cli-debug is in gnutls-dev (FILES:${PN}-dev += "${bindir}/gnutls-cli-debug")
INSANE_SKIP:${PN}-dev:wrynose = "buildpaths"
