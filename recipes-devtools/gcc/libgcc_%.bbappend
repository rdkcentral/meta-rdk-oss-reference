SECURITY_CFLAGS:remove = "-Werror=format-security"
TARGET_CC_ARCH:remove = "-Werror=format-security"
CFLAGS:remove = "\${DEBUG_FLAGS}"

do_configure:prepend() {
    CFLAGS=$(printf '%s\n' "${CFLAGS}" | sed 's/\${DEBUG_FLAGS}//g')
}