# rdk.conf DISTRO_FEATURES_OPTED_OUT += "gobject-introspection-data" breaks the transitive chain delivering m4-native; bison-native needs m4 on PATH.
DEPENDS:append:wrynose = " m4-native"

# coreutils conflicts with busybox on RDK targets; xtests scripts use bash (#!/bin/bash), so keep bash as runtime dep.
RDEPENDS:${PN}-xtests:remove:wrynose = "coreutils"

# bash is a runtime-only dep for xtests; OE6 [build-deps] fires in standalone builds but not in image builds where bash is already in the task graph.
INSANE_SKIP:${PN}-xtests:append:wrynose = " build-deps"

