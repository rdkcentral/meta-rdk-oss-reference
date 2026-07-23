# gdbm 1.8.3 uses AM_PROG_LIBTOOL without AM_INIT_AUTOMAKE, so autoreconf
# skips aclocal and leaves the stale libtool macros in aclocal.m4 untouched.
# This causes a libtool version mismatch at compile time because macro_revision
# in aclocal.m4 does not match package_revision in ltmain.sh.
# OE-core commit 7da2290 (2026-03-09) removed the global workaround from
# autotools.bbclass that previously covered this case. Explicitly run aclocal
# to regenerate aclocal.m4 with current libtool macros before autoreconf runs.
#
# gdbm 1.8.3 does not support VPATH (out-of-tree) builds. OE wrynose sets
# B = "${WORKDIR}/build" by default, but configure creates the Makefile in ${S},
# leaving ${B} empty and causing do_compile to fail with "no makefile found".
# Force in-tree builds by setting B = S for wrynose.
# gdbm 1.8.3 uses AM_PROG_LIBTOOL without AM_INIT_AUTOMAKE, so autoreconf
# skips aclocal and leaves the stale libtool macros in aclocal.m4 untouched.
# This causes a libtool version mismatch at compile time because macro_revision
# in aclocal.m4 does not match package_revision in ltmain.sh.
# OE-core commit 7da2290 (2026-03-09) removed the global workaround from
# autotools.bbclass that previously covered this case. Explicitly run aclocal
# to regenerate aclocal.m4 with current libtool macros before autoreconf runs.
#
# gdbm 1.8.3 does not support VPATH (out-of-tree) builds. OE wrynose sets
# B = "${WORKDIR}/build" by default, but configure creates the Makefile in ${S},
# leaving ${B} empty and causing do_compile to fail with "no makefile found".
# Force in-tree builds by setting B = S for wrynose.
B:wrynose = "${S}"

do_configure:prepend:wrynose() {
    cd ${S} && aclocal --aclocal-path=${STAGING_DATADIR}/aclocal/
}

# GCC 15 enforces C99 strict prototypes: void (*fatal_err)() means no arguments
# in C99+, but gdbm 1.8.3 calls it with one argument (K&R convention).
# -std=gnu89 restores the pre-C99 behaviour where () means unspecified args.
# PROPER FIX: change gdbmdefs.h line 170 to void (*fatal_err)(const char *) and
# update all callers. Safe to do once kirkstone broadband builds are retired.
CFLAGS:append:wrynose = " -std=gnu89"
