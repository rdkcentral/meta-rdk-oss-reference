SUMMARY = "Broadband OSS packagegroup"

LICENSE = "MIT"

PACKAGE_ARCH = "${OSS_LAYER_ARCH}"

inherit packagegroup


PV = "1.0.0"
PR = "r0"

# poky components
RDEPENDS:${PN} += "\
     cracklib \ 
     systemd-conf \ 
     libxml2 \ 
     kmod \ 
     libical \ 
     util-linux \ 
     ncurses \ 
     autoconf-archive \ 
     libgcrypt \ 
     apr \ 
     boost \ 
     tcp-wrappers \ 
     libpsl \ 
     util-linux-libuuid \ 
     bzip2 \ 
     bind \ 
     sysfsutils \ 
     go-cross-cortexa15hf-neon \ 
     mtd-utils \ 
     icu \ 
     flex \ 
     net-tools \ 
     popt \ 
     base-files \ 
     libffi \ 
     glib-networking \ 
     shadow-securetty \ 
     libnl \ 
     libtool-cross \ 
     libmnl \ 
     elfutils \ 
     lzo \ 
     iproute2 \ 
     openssl \ 
     systemd \ 
     libsoup-2.4 \ 
     attr \ 
     libtirpc \ 
     libtool \ 
     libgcc-initial \ 
     libnsl2 \ 
     shared-mime-info \ 
     json-c \ 
     systemd-serialgetty \ 
     vala \ 
     perl \ 
     glibc \ 
     libcap-ng \ 
     curl \ 
     gptfdisk \ 
     sqlite3 \ 
     shadow \ 
     xz \ 
     depmodwrapper-cross \ 
     dbus \ 
     opkg-utils \ 
     socat \ 
     e2fsprogs \ 
     rng-tools \ 
     libevent \ 
     linux-libc-headers \ 
     libjitterentropy \ 
     quota \ 
     libgpg-error \ 
     libidn2 \ 
     zstd \ 
     libbsd \ 
     bash-completion \ 
     go-runtime \ 
     libatomic-ops \ 
     base-passwd \ 
     libpam \ 
     libxcrypt \ 
     libcap \ 
     binutils-cross-arm \ 
     glib-2.0 \ 
     libpcap \ 
     rpcbind \ 
     busybox \ 
     gcc-source-11.3.0 \ 
     sysvinit-inittab \ 
     acl \ 
     ca-certificates \ 
     pciutils \ 
     run-postinsts \ 
     python3 \ 
     shadow-sysroot \ 
     gobject-introspection \ 
     expat \ 
     libgcc \ 
     iptables \ 
     qemuwrapper-cross \ 
     ethtool \ 
     libmd \ 
     gcc-cross-arm \ 
"

# meta-openembedded components
RDEPENDS:${PN} += "\
     libnetfilter-acct \ 
     libtinyxml \ 
     jansson \ 
     avro-c \ 
     ruli \ 
     ez-ipupdate \ 
     tcpdump \ 
     ndisc6 \ 
     hostapd \ 
     ebtables \ 
     libnetfilter-conntrack \ 
     cmocka \ 
     ssmtp \ 
     uthash \ 
     quagga \ 
     protobuf \ 
     protobuf-c \ 
     fcgi \ 
     re2 \ 
     yajl \ 
     libnetfilter-cttimeout \ 
     pps-tools \ 
     heaptrack \ 
     iperf2 \ 
     jsoncpp \ 
     libnetfilter-cthelper \ 
     cjson \ 
     netperf \ 
     abseil-cpp \ 
     bridge-utils \ 
     mosquitto \ 
     libnetfilter-queue \ 
     miniupnpd \ 
     conntrack-tools \ 
     s-nail \ 
     neon \ 
     keyutils \ 
     smartmontools \ 
     gssdp \ 
     stunnel \ 
     igmpproxy \ 
     spawn-fcgi \ 
     glog \ 
     nanomsg \ 
     ntp \ 
     grpc \ 
     safec \ 
     googletest \ 
     liboauth \ 
     c-ares \ 
     libev \ 
     libnfnetlink \ 
     liboop \ 
     breakpad \ 
     libnetfilter-log \ 
     rapidjson \ 
"

# meta-rdk-oss-reference components
RDEPENDS:${PN} += "\
     nlohmann-json \ 
     gupnp \ 
     net-snmp \ 
     log4c \ 
     safec-common-wrapper \ 
     nettle \ 
     gettext \ 
     trower-base64 \ 
     libunwind \ 
     mbedtls \ 
     m4 \ 
     sed \ 
     libupnp \ 
     libarchive \ 
     nghttp2 \ 
     libpcre \ 
     gnutls \ 
     gdbm \ 
     os-release \ 
     coreutils \ 
     duktape \ 
     breakpad-wrapper \ 
     volatile-binds \ 
     gmp \ 
     readline \ 
     iw \ 
     apparmor \ 
     logrotate \ 
     bash \ 
     bluez5 \ 
     zlib \ 
     linenoise \ 
     iksemel \ 
     smcroute \ 
     nopoll \ 
     msgpack-c \ 
"
