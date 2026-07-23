# python3-build-native uses pyproject-build --no-isolation which calls
# packaging.requirements to check build dependencies. python3-packaging-native
# is only in python3-build-native's RDEPENDS and is not propagated into the
# recipe-sysroot-native of packages that depend on python3-build-native.
# Explicitly add it so the import succeeds during do_compile.
DEPENDS:append:class-native = " python3-packaging-native"
