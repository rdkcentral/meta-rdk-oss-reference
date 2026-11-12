
# Disable PHP features not required for RDK-B

PACKAGECONFIG:remove = "mysql"
PACKAGECONFIG:remove = "sqlite3"
PACKAGECONFIG:remove = "imap"

EXTRA_OECONF += " \
    --with-curl=${STAGING_LIBDIR}/.. \
    --with-openssl=${STAGING_INCDIR}/.. \
"
DEPENDS:append = " openssl curl"


CACHED_CONFIGUREVARS:remove = " ac_cv_func_dlopen=no"
CFLAGS:append = " -DHAVE_LIBDL "
LDFLAGS:append = " -ldl "
