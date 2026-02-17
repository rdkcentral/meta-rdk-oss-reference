# Skip format-overflow warning for glibc-tests when ptest is enabled
# Needed for ptest compilation to succeed
CFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', ' -Wno-error=format-overflow', '', d)}"
