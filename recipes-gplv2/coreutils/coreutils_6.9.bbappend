do_configure:append:wrynose() {

    # ARGMATCH_DIE / usage()
    sed -i 's/extern void usage ()/extern void usage (int);/' \
        ${B}/lib/config.h

    # mktime() already declared by <time.h>
    sed -i '/time_t mktime[[:space:]]*();/d' \
        ${S}/lib/posixtm.c

    # getgroup/getuser are local helper functions, keep explicit prototype
    sed -i \
        's/char \*getgroup ();/char *getgroup (unsigned long int);/' \
        ${S}/src/ls.c

    sed -i \
        's/char \*getuser ();/char *getuser (unsigned long int);/' \
        ${S}/src/ls.c

    # putenv() already declared by system headers
    sed -i '/int putenv[[:space:]]*();/d' \
        ${S}/src/date.c

    sed -i '/int putenv[[:space:]]*();/d' \
        ${S}/src/env.c

    # sethostname() already declared by system headers
    sed -i '/int sethostname[[:space:]]*();/d' \
        ${S}/src/hostname.c

    # getugroups() is a local gnulib function, keep explicit prototype
    sed -i \
        's/int getugroups ();/int getugroups (int, gid_t *, const char *, gid_t);/' \
        ${S}/src/id.c

    # getloadavg() already declared by system headers/gnulib
    sed -i '/int getloadavg[[:space:]]*();/d' \
        ${S}/src/uptime.c

    sed -i '/char \*ttyname[[:space:]]*();/d' \
        ${S}/src/who.c

    sed -i '/char \*ttyname[[:space:]]*();/d' \
        ${S}/src/pinky.c

    sed -i '/char \*crypt[[:space:]]*();/d' ${S}/src/su.c
    sed -i '/char \*getusershell[[:space:]]*();/d' ${S}/src/su.c
    sed -i '/void endusershell[[:space:]]*();/d' ${S}/src/su.c
    sed -i '/void setusershell[[:space:]]*();/d' ${S}/src/su.c

    sed -i '/void free[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*malloc[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*memchr[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*realloc[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*getenv[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*getlogin[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/char \*ttyname[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/uid_t geteuid[[:space:]]*();/d' ${S}/src/system.h
    sed -i '/uid_t getuid[[:space:]]*();/d' ${S}/src/system.h
}

CFLAGS:append = " -Wno-error=implicit-function-declaration"

do_install:append:wrynose() {
    # Rename all standard coreutils binaries to include .${BPN} suffix
    for cmd in ${base_bindir_progs} ${bindir_progs} ${sbindir_progs} df mktemp nice printenv base64; do
        for p in ${bindir} ${base_bindir} ${sbindir}; do
            if [ -f "${D}${p}/${cmd}" ] && [ ! -f "${D}${p}/${cmd}.${BPN}" ]; then
                mv -f "${D}${p}/${cmd}" "${D}${p}/${cmd}.${BPN}" || true
            fi
        done
    done

    # Special handling for '[' (bracket) since [.${BPN} breaks update-alternatives
    if [ -f "${D}${bindir}/[" ]; then
        mv -f "${D}${bindir}/[" "${D}${bindir}/lbracket.${BPN}" || true
    fi
}
