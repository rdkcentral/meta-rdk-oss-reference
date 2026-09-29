# Force use of log4c's builtin yacc/lex code for parsing the log4crc config
# file instead of linking with Expat. This is a temporary workaround for issues
# seen with the RDK default log4crc config files, which contain invalid XML (ie
# sequences of '-' characters within XML comments). Expat generates errors when
# parsing these invalid config files but the log4crc builtin XML parser is more
# forgiving...

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PACKAGECONFIG:remove:wrynose = "expat"
SRC_URI:append = " \
        file://04log4c_sizewin.patch \
        file://03log4c_rollingfileapender.patch \
        file://memory-leak-fix-log4c.patch \
"
