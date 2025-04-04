SUMMARY = "linenoise library"
DESCRIPTION = "Recipe to build library for linenoise"
SECTION = "libs"
HOMEPAGE = "https://github.com/antirez/linenoise"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=faa55ac8cbebebcb4a84fe1ea2879578"

PV = "1.0.0+git${SRCPV}"
PR = "r1"

SRC_URI = "git://github.com/antirez/linenoise.git;protocol=https"
SRCREV = "97d2850af13c339369093b78abe5265845d78220"

# Support for linenoiseHistoryPrint
SRC_URI += "file://001-linenoise-history.patch"

# To compile and generate liblinenoise.so
SRC_URI += "file://002-linenoise-cmakelists.patch"

S = "${WORKDIR}/git"

inherit cmake pkgconfig
