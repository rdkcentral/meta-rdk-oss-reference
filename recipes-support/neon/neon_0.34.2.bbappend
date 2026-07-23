# gnutls 3.3.30 (target, kept for GPLv2 compliance) lacks GNUTLS_TLS1_3
# which is used unconditionally in ne_socket.c:2111.  Switch to openssl which
# is always available on the target and has no GPL constraints.
PACKAGECONFIG:remove:wrynose = "gnutls"
PACKAGECONFIG:append:wrynose = " openssl"
