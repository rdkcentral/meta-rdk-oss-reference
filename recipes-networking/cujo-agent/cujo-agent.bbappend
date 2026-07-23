# OE5→OE6 migration: virtual/${TARGET_PREFIX}gcc was replaced by virtual/cross-cc
# Reassign do_unpack[depends] with the OE6 cross-compiler virtual provider.
do_unpack[depends] = "virtual/${MLPREFIX}cross-cc:do_populate_sysroot pkgconfig-native:do_populate_sysroot"
