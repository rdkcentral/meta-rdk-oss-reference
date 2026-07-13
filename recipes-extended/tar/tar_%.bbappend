ALTERNATIVE_PRIORITY[tar] = "20"

TARGET_CFLAGS:append = "  \
        -Wno-error=incompatible-pointer-types \
        -Wno-error=discarded-qualifiers \
"
