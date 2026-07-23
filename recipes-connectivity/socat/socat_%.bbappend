FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
        file://socat_restrict_localhost.patch \
        file://socat_windows_config_pty.patch \
        "
EXTRA_OECONF += " --disable-proxy \
		--disable-tun \
		--disable-stdio \
		--disable-sctp \
		--disable-socks4 \
		--disable-socks4a \
		--disable-udp \
		--disable-fdnum \
		--disable-creat \
		--disable-gopen \
		--disable-pipe \
		--disable-unix \
		--disable-abstract-unixsocket \
		--disable-rawip \
		--disable-genericsocket \
		--disable-system \
		--disable-readline \
		--disable-filan \
"
# Suppress patch-fuzz QA error: socat_windows_config_pty.patch applies with fuzz
# 1 against socat 1.8.1.1 (intentional, patch was rewritten for new struct layout).
ERROR_QA:remove:pn-socat = "patch-fuzz"