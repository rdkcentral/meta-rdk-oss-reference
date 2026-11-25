SECURITY_STRINGFORMAT:remove = "-Werror=format-security"
DEBUG_FLAGS = ""
EXTRA_OECONF:append = " --without-headers"

do_configure:prepend() {
	install -d ${STAGING_INCDIR}
	cat > ${STAGING_INCDIR}/stdio.h <<'EOF'
#ifndef _STDIO_H
#define _STDIO_H
int printf(const char *, ...);
#endif
EOF
}
