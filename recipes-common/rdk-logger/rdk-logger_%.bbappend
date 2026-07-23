# GCC 15 defaults to -std=gnu23 which promotes certain diagnostics to errors:
#  - [-Wincompatible-pointer-types]: rdk_debug_priv.c:129 log4c callback const mismatch
#  - [-Wimplicit-function-declaration]: rdk_dynamic_logger.c:97 rdk_dbg_priv_reconfig
# Downgrade these to warnings so the build completes.
CFLAGS:append:wrynose = " -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration"

# OE6 migration: meta-rdk base recipe and meta-rdk-broadband bbappend both use
# FILES_${PN} (OE5 syntax). In OE6 this is ignored, so installed files under
# /rdklogger, /fss/gw/rdklogger, and /usr/lib/rdk are not shipped to any package.
# Add them here using OE6 FILES:${PN} syntax.
FILES:${PN}:append:wrynose = " /rdklogger /rdklogger/log4crc /fss /fss/gw /fss/gw/rdklogger /fss/gw/rdklogger/log4crc /usr/lib/rdk /usr/lib/rdk/logMilestone.sh ${base_libdir}/rdk ${base_libdir}/rdk/logMilestone.sh"


# rdk-logger_git.bb uses OE5 CFLAGS_append / LDFLAGS_append with backtick pkg-config
# expressions when 'safec' is in DISTRO_FEATURES:
#   CFLAGS_append  = " ... -I${STAGING_INCDIR}/safeclib "
#   LDFLAGS_append = " ... -L${STAGING_LIBDIR} -lsafec "
#
# In OE6 these are processed by the compat layer and stored as literal strings in the
# BitBake datastore. At task execution time the shell exports them as environment
# variables containing the literal backtick text. POSIX shell does NOT re-evaluate
# backtick expressions that appear inside $VAR expansions, so autoconf's compiler
# test receives '--cflags' and '--libs' as GCC flags, causing configure to fail.
#
# Fix: resolve the pkg-config values in a do_configure:prepend and replace the
# literal backtick tokens with the actual include/library flags.

do_configure:prepend:wrynose () {
    # OE6: rdkb_log4crc is a file:// SRC_URI item from meta-rdk-broadband.
    # It unpacks to ${WORKDIR}/sources/rdkb_log4crc (UNPACKDIR) but the
    # meta-rdk-broadband do_configure:append expects it at ${WORKDIR}/rdkb_log4crc.
    if [ -f "${UNPACKDIR}/rdkb_log4crc" ] && [ ! -f "${WORKDIR}/rdkb_log4crc" ]; then
        cp "${UNPACKDIR}/rdkb_log4crc" "${WORKDIR}/rdkb_log4crc"
    fi

    # Replacement values using sysroot-relative staging paths
    safec_cflags="-I${STAGING_INCDIR}/safeclib"
    safec_libs="-L${STAGING_LIBDIR} -lsafec"

    # Remove literal backtick pkg-config tokens and append resolved flags.
    # Use | as sed delimiter to avoid conflicts with / in sysroot paths.
    # Single-quoted sed patterns ensure backticks are treated literally.
    CFLAGS=$(printf '%s' "${CFLAGS}" | sed 's|-I${STAGING_INCDIR}/safeclib||g')
    LDFLAGS=$(printf '%s' "${LDFLAGS}" | sed 's|-L${STAGING_LIBDIR} -lsafec||g')
    CFLAGS="${CFLAGS} ${safec_cflags}"
    LDFLAGS="${LDFLAGS} ${safec_libs}"
    export CFLAGS LDFLAGS
}
