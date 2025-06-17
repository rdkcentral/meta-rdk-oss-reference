# PREFERRED VERSION settings
PREFERRED_VERSION_bash ?= "3.2.%"
PREFERRED_VERSION_openssl = "3.0.%"
PREFERRED_VERSION_openssl-native = "3.0.%"
PREFERRED_VERSION_nativesdk-openssl = "3.0.%"
PREFERRED_VERSION_civetweb = "1.10+git%"
PREFERRED_VERSION_wpa-supplicant = "2.10"

#Fix the version diff against stable2
PREFERRED_VERSION_libstd-rs = "1.72.0"
PREFERRED_VERSION_cargo = "1.72.0"
PREFERRED_VERSION_cargo-native = "1.72.0"
PREFERRED_VERSION_rust = "1.72.0"
PREFERRED_VERSION_rust-native = "1.72.0"
PREFERRED_VERSION_rust-llvm = "1.72.0"
PREFERRED_VERSION_rust-llvm-native = "1.72.0"
PREFERRED_VERSION_rust-cross-canadian = "1.72.0"
PREFERRED_VERSION_rust-cross-canadian-native = "1.72.0"
PREFERRED_VERSION_readline-native = "8.1.2"
PREFERRED_VERSION_nativesdk-readline = "8.1.2"
PREFERRED_VERSION_bluez5 = "5.48"

#To resolve gettext native version mismatch due to layer priority
PREFERRED_VERSION_gettext-native = "0.21"

#Preferred versions from Vendor layer
PREFERRED_VERSION_libdrm = "2.4.110"
PREFERRED_VERSION_nativesdk-libdrm = "2.4.110"

# Workaround to build allarch packags as oss arch
MULTILIB_VARIANTS:pn-alsa-topology-conf = " multilib "
MULTILIB_VARIANTS:pn-alsa-ucm-conf = " multilib "
MULTILIB_VARIANTS:pn-autoconf-archive = " multilib "
MULTILIB_VARIANTS:pn-ca-certificates = " multilib "
MULTILIB_VARIANTS:pn-iso-codes = " multilib "
MULTILIB_VARIANTS:pn-run-postinsts = " multilib "
MULTILIB_VARIANTS:pn-tzdata = " multilib "
MULTILIB_VARIANTS:pn-update-rc.d = " multilib "
MULTILIB_VARIANTS:pn-wayland-protocols = " multilib "
MULTILIB_VARIANTS:pn-wireless-regdb = " multilib "
MULTILIB_VARIANTS:pn-liberation-fonts = " multilib "

# Package revisions and architecture configurations
PR:pn-abseil-cpp = "r0"
PACKAGE_ARCH:pn-abseil-cpp = "${OSS_LAYER_ARCH}"

PR:pn-acl = "r0"
PACKAGE_ARCH:pn-acl = "${OSS_LAYER_ARCH}"

PR:pn-alsa-lib = "r0"
PACKAGE_ARCH:pn-alsa-lib = "${OSS_LAYER_ARCH}"

#PR:pn-alsa-plugins = "r0"
#PACKAGE_ARCH:pn-alsa-plugins =  "${OSS_LAYER_ARCH}"

PR:pn-alsa-topology-conf = "r0"
PACKAGE_ARCH:pn-alsa-topology-conf = "${OSS_LAYER_ARCH}"

PR:pn-alsa-state = "r5"
PACKAGE_ARCH:pn-alsa-state = "${OSS_LAYER_ARCH}"

PR:pn-alsa-topology-conf = "r0"
PACKAGE_ARCH:pn-alsa-topology-conf = "${OSS_LAYER_ARCH}"

PR:pn-alsa-ucm-conf = "r0"
PACKAGE_ARCH:pn-alsa-ucm-conf = "${OSS_LAYER_ARCH}"

PR:pn-alsa-utils = "r0"
PACKAGE_ARCH:pn-alsa-utils = "${OSS_LAYER_ARCH}"

PR:pn-alsa-utils-scripts = "r0"
PACKAGE_ARCH:pn-alsa-utils-scripts = "${OSS_LAYER_ARCH}"

PR:pn-apparmor = "r0"
PACKAGE_ARCH:pn-apparmor = "${OSS_LAYER_ARCH}"

PR:pn-atk = "r0"
PACKAGE_ARCH:pn-atk = "${OSS_LAYER_ARCH}"

PR:pn-atk = "r0"
PACKAGE_ARCH:pn-atk = "${OSS_LAYER_ARCH}"

PR:pn-attr = "r0"
PACKAGE_ARCH:pn-attr = "${OSS_LAYER_ARCH}"

PR:pn-autoconf-archive = "r0"
PACKAGE_ARCH:pn-autoconf-archive = "${OSS_LAYER_ARCH}"

PR:pn-avahi = "r1"
PACKAGE_ARCH:pn-avahi = "${OSS_LAYER_ARCH}"

PR:pn-base-files = "r89"
PACKAGE_ARCH:pn-base-files = "${OSS_LAYER_ARCH}"

PR:pn-base-passwd = "r0"
PACKAGE_ARCH:pn-base-passwd = "${OSS_LAYER_ARCH}"

PR:pn-bash = "r0"
PACKAGE_ARCH:pn-bash = "${OSS_LAYER_ARCH}"

PR:pn-bash-completion = "r0"
PACKAGE_ARCH:pn-bash-completion = "${OSS_LAYER_ARCH}"

PR:pn-bind = "r0"
PACKAGE_ARCH:pn-bind = "${OSS_LAYER_ARCH}"

PR:pn-boost = "r0"
PACKAGE_ARCH:pn-boost = "${OSS_LAYER_ARCH}"

PR:pn-breakpad = "r1"
PACKAGE_ARCH:pn-breakpad = "${OSS_LAYER_ARCH}"

PR:pn-breakpad-wrapper = "r0"
PACKAGE_ARCH:pn-breakpad-wrapper = "${OSS_LAYER_ARCH}"

PR:pn-brotli = "r0"
PACKAGE_ARCH:pn-brotli = "${OSS_LAYER_ARCH}"

PR:pn-busybox = "r1"
PACKAGE_ARCH:pn-busybox = "${OSS_LAYER_ARCH}"

PR:pn-busybox = "r1"
PACKAGE_ARCH:pn-busybox = "${OSS_LAYER_ARCH}"

PR:pn-bzip2 = "r0"
PACKAGE_ARCH:pn-bzip2 = "${OSS_LAYER_ARCH}"

PR:pn-ca-certificates = "r2"
PACKAGE_ARCH:pn-ca-certificates = "${OSS_LAYER_ARCH}"

PR:pn-c-ares = "r0"
PACKAGE_ARCH:pn-c-ares = "${OSS_LAYER_ARCH}"

PR:pn-civetweb = "r0"
PACKAGE_ARCH:pn-civetweb = "${OSS_LAYER_ARCH}"

PR:pn-cjson = "r0"
PACKAGE_ARCH:pn-cjson = "${OSS_LAYER_ARCH}"

PR:pn-coreutils = "r0"
PACKAGE_ARCH:pn-coreutils = "${OSS_LAYER_ARCH}"

PR:pn-cracklib = "r0"
PACKAGE_ARCH:pn-cracklib = "${OSS_LAYER_ARCH}"

PR:pn-crun = "r0"
PACKAGE_ARCH:pn-crun = "${OSS_LAYER_ARCH}"

PR:pn-ctemplate = "r3"
PACKAGE_ARCH:pn-ctemplate = "${OSS_LAYER_ARCH}"

PR:pn-cunit = "r0"
PACKAGE_ARCH:pn-cunit = "${OSS_LAYER_ARCH}"

PR:pn-curl = "r1"
PACKAGE_ARCH:pn-curl = "${OSS_LAYER_ARCH}"

PR:pn-db = "r1"
PACKAGE_ARCH:pn-db = "${OSS_LAYER_ARCH}"

PR:pn-dbus = "r0"
PACKAGE_ARCH:pn-dbus = "${OSS_LAYER_ARCH}"

PR:pn-dbus-glib = "r0"
PACKAGE_ARCH:pn-dbus-glib = "${OSS_LAYER_ARCH}"

PR:pn-dibbler= "r1"
PACKAGE_ARCH:pn-dibbler = "${OSS_LAYER_ARCH}"

PR:pn-dnsmasq = "r1"
PACKAGE_ARCH:pn-dnsmasq = "${OSS_LAYER_ARCH}"

PR:pn-dosfstools = "r0"
PACKAGE_ARCH:pn-dosfstools = "${OSS_LAYER_ARCH}"

PR:pn-e2fsprogs = "r0"
PACKAGE_ARCH:pn-e2fsprogs = "${OSS_LAYER_ARCH}"

PR:pn-ebtables = "r4"
PACKAGE_ARCH:pn-ebtables = "${OSS_LAYER_ARCH}"

PR:pn-ethtool = "r0"
PACKAGE_ARCH:pn-ethtool = "${OSS_LAYER_ARCH}"

PR:pn-elfutils = "r0"
PACKAGE_ARCH:pn-elfutils = "${OSS_LAYER_ARCH}"

PR:pn-evtest = "r0"
PACKAGE_ARCH:pn-evtest = "${OSS_LAYER_ARCH}"

PR:pn-expat = "r0"
PACKAGE_ARCH:pn-expat = "${OSS_LAYER_ARCH}"

PR:pn-fcgi = "r0"
PACKAGE_ARCH:pn-fcgi = "${OSS_LAYER_ARCH}"

PR:pn-file = "r0"
PACKAGE_ARCH:pn-file = "${OSS_LAYER_ARCH}"

PR:pn-findutils = "r0"
PACKAGE_ARCH:pn-findutils = "${OSS_LAYER_ARCH}"

PR:pn-flac = "r0"
PACKAGE_ARCH:pn-flac = "${OSS_LAYER_ARCH}"

PR:pn-flex = "r0"
PACKAGE_ARCH:pn-flex = "${OSS_LAYER_ARCH}"

PR:pn-fontconfig = "r0"
PACKAGE_ARCH:pn-fontconfig = "${OSS_LAYER_ARCH}"

PR:pn-freetype = "r1"
PACKAGE_ARCH:pn-freetype = "${OSS_LAYER_ARCH}"

PR:pn-fribidi = "r0"
PACKAGE_ARCH:pn-fribidi = "${OSS_LAYER_ARCH}"

PR:pn-gawk = "r2"
PACKAGE_ARCH:pn-gawk = "${OSS_LAYER_ARCH}"

PR:pn-gcc-runtime = "r0"
PACKAGE_ARCH:pn-gcc-runtime = "${OSS_LAYER_ARCH}"

PR:pn-gcc-sanitizers = "r0"
PACKAGE_ARCH:pn-gcc-sanitizers = "${OSS_LAYER_ARCH}"

PR:pn-sed = "r0"
PACKAGE_ARCH:pn-sed = "${OSS_LAYER_ARCH}"

PR:pn-gdbm = "r4"
PACKAGE_ARCH:pn-gdbm = "${OSS_LAYER_ARCH}"

PR:pn-gdk-pixbuf = "r0"
PACKAGE_ARCH:pn-gdk-pixbuf = "${OSS_LAYER_ARCH}"

PR:pn-gettext = "r6"
PACKAGE_ARCH:pn-gettext = "${OSS_LAYER_ARCH}"

PR:pn-gflags = "r0"
PACKAGE_ARCH:pn-gflags = "${OSS_LAYER_ARCH}"

PR:pn-glib-2.0 = "r1"
PACKAGE_ARCH:pn-glib-2.0 = "${OSS_LAYER_ARCH}"

PR:pn-glibc = "r1"
PACKAGE_ARCH:pn-glibc = "${OSS_LAYER_ARCH}"

PR:pn-glibc-locale = "r0"
PACKAGE_ARCH:pn-glibc-locale = "${OSS_LAYER_ARCH}"

PR:pn-glibc-mtrace = "r0"
PACKAGE_ARCH:pn-glibc-mtrace = "${OSS_LAYER_ARCH}"

PR:pn-glib-networking = "r1"
PACKAGE_ARCH:pn-glib-networking = "${OSS_LAYER_ARCH}"

PR:pn-openssh = "r0"
PACKAGE_ARCH:pn-openssh = "${OSS_LAYER_ARCH}"

PR:pn-gmp = "r0"
PACKAGE_ARCH:pn-gmp = "${OSS_LAYER_ARCH}"

PR:pn-gnutls = "r1"
PACKAGE_ARCH:pn-gnutls = "${OSS_LAYER_ARCH}"

PR:pn-gobject-introspection = "r0"
PACKAGE_ARCH:pn-gobject-introspection = "${OSS_LAYER_ARCH}"

PR:pn-googletest = "r0"
PACKAGE_ARCH:pn-googletest = "${OSS_LAYER_ARCH}"

PR:pn-graphite2 = "r0"
PACKAGE_ARCH:pn-graphite2 = "${OSS_LAYER_ARCH}"

PR:pn-grpc = "r0"
PACKAGE_ARCH:pn-grpc = "${OSS_LAYER_ARCH}"

PR:pn-gssdp = "r0"
PACKAGE_ARCH:pn-gssdp = "${OSS_LAYER_ARCH}"

PR:pn-gupnp = "r1"
PACKAGE_ARCH:pn-gupnp = "${OSS_LAYER_ARCH}"

PR:pn-harfbuzz = "r0"
PACKAGE_ARCH:pn-harfbuzz = "${OSS_LAYER_ARCH}"

PR:pn-heaptrack = "r0"
PACKAGE_ARCH:pn-heaptrack = "${OSS_LAYER_ARCH}"

PR:pn-hiredis = "r0"
PACKAGE_ARCH:pn-hiredis = "${OSS_LAYER_ARCH}"

PR:pn-icu = "r0"
PACKAGE_ARCH:pn-icu = "${OSS_LAYER_ARCH}"

PR:pn-init-system-helpers = "r0"
PACKAGE_ARCH:pn-init-system-helpers = "${OSS_LAYER_ARCH}"

PR:pn-initscripts = "r155"
PACKAGE_ARCH:pn-initscripts = "${OSS_LAYER_ARCH}"

PR:pn-iperf3 = "r0"
PACKAGE_ARCH:pn-iperf3 = "${OSS_LAYER_ARCH}"

PR:pn-iptables = "r0"
PACKAGE_ARCH:pn-iptables = "${OSS_LAYER_ARCH}"

PR:pn-iso-codes = "r0"
PACKAGE_ARCH:pn-iso-codes = "${OSS_LAYER_ARCH}"

PR:pn-iw = "r0"
PACKAGE_ARCH:pn-iw = "${OSS_LAYER_ARCH}"

PR:pn-jansson = "r0"
PACKAGE_ARCH:pn-jansson = "${OSS_LAYER_ARCH}"

PR:pn-jquery = "r3"
PACKAGE_ARCH:pn-jquery = "${OSS_LAYER_ARCH}"

PR:pn-json-c = "r0"
PACKAGE_ARCH:pn-json-c = "${OSS_LAYER_ARCH}"

PR:pn-jsoncpp = "r0"
PACKAGE_ARCH:pn-jsoncpp = "${OSS_LAYER_ARCH}"

PR:pn-jsonrpc = "r0"
PACKAGE_ARCH:pn-jsonrpc = "${OSS_LAYER_ARCH}"

PR:pn-kbd = "r0"
PACKAGE_ARCH:pn-kbd = "${OSS_LAYER_ARCH}"

PR:pn-keyutils = "r0"
PACKAGE_ARCH:pn-keyutils = "${OSS_LAYER_ARCH}"

PR:pn-kmod = "r0"
PACKAGE_ARCH:pn-kmod = "${OSS_LAYER_ARCH}"

PR:pn-lcms = "r0"
PACKAGE_ARCH:pn-lcms = "${OSS_LAYER_ARCH}"

PR:pn-libaio = "r0"
PACKAGE_ARCH:pn-libaio = "${OSS_LAYER_ARCH}"

PR:pn-libarchive = "r0"
PACKAGE_ARCH:pn-libarchive = "${OSS_LAYER_ARCH}"

PR:pn-libatomic-ops = "r0"
PACKAGE_ARCH:pn-libatomic-ops = "${OSS_LAYER_ARCH}"

PR:pn-libbsd = "r0"
PACKAGE_ARCH:pn-libbsd = "${OSS_LAYER_ARCH}"

PR:pn-libcap = "r0"
PACKAGE_ARCH:pn-libcap = "${OSS_LAYER_ARCH}"

PR:pn-libcap-ng = "r0"
PACKAGE_ARCH:pn-libcap-ng = "${OSS_LAYER_ARCH}"

PR:pn-libcgroup = "r0"
PACKAGE_ARCH:pn-libcgroup = "${OSS_LAYER_ARCH}"

PR:pn-libcheck = "r0"
PACKAGE_ARCH:pn-libcheck = "${OSS_LAYER_ARCH}"

PR:pn-libcroco = "r0"
PACKAGE_ARCH:pn-libcroco = "${OSS_LAYER_ARCH}"

PR:pn-libdaemon = "r0"
PACKAGE_ARCH:pn-libdaemon = "${OSS_LAYER_ARCH}"

PR:pn-libdash = "r1"
PACKAGE_ARCH:pn-libdash = "${OSS_LAYER_ARCH}"

PR:pn-libdwarf = "r0"
PACKAGE_ARCH:pn-libdwarf = "${OSS_LAYER_ARCH}"

PR:pn-liberation-fonts = "r0"
PACKAGE_ARCH:pn-liberation-fonts = "${OSS_LAYER_ARCH}"

PR:pn-libev = "r0"
PACKAGE_ARCH:pn-libev = "${OSS_LAYER_ARCH}"

PR:pn-libevdev = "r0"
PACKAGE_ARCH:pn-libevdev = "${OSS_LAYER_ARCH}"

PR:pn-libevent = "r0"
PACKAGE_ARCH:pn-libevent = "${OSS_LAYER_ARCH}"

PR:pn-libexif = "r0"
PACKAGE_ARCH:pn-libexif = "${OSS_LAYER_ARCH}"

PR:pn-libffi = "r0"
PACKAGE_ARCH:pn-libffi = "${OSS_LAYER_ARCH}"

PR:pn-libgcc = "r0"
PACKAGE_ARCH:pn-libgcc = "${OSS_LAYER_ARCH}"

PR:pn-libgcc-initial = "r0"
PACKAGE_ARCH:pn-libgcc-initial = "${OSS_LAYER_ARCH}"

PR:pn-libgcrypt = "r0"
PACKAGE_ARCH:pn-libgcrypt = "${OSS_LAYER_ARCH}"

PR:pn-libgpg-error = "r0"
PACKAGE_ARCH:pn-libgpg-error = "${OSS_LAYER_ARCH}"

PR:pn-libgudev = "r0"
PACKAGE_ARCH:pn-libgudev = "${OSS_LAYER_ARCH}"

PR:pn-libical = "r0"
PACKAGE_ARCH:pn-libical = "${OSS_LAYER_ARCH}"

PR:pn-libidn2 = "r0"
PACKAGE_ARCH:pn-libidn2 = "${OSS_LAYER_ARCH}"

PR:pn-libinput = "r0"
PACKAGE_ARCH:pn-libinput = "${OSS_LAYER_ARCH}"

PR:pn-libjpeg = "r0"
PACKAGE_ARCH:pn-libjpeg = "${OSS_LAYER_ARCH}"

PR:pn-libmanette = "r1"
PACKAGE_ARCH:pn-libmanette = "${OSS_LAYER_ARCH}"

PR:pn-libmd = "r0"
PACKAGE_ARCH:pn-libmd = "${OSS_LAYER_ARCH}"

PR:pn-libmicrohttpd = "r0"
PACKAGE_ARCH:pn-libmicrohttpd = "${OSS_LAYER_ARCH}"

PR:pn-libmng = "r0"
PACKAGE_ARCH:pn-libmng = "${OSS_LAYER_ARCH}"

PR:pn-libmnl = "r0"
PACKAGE_ARCH:pn-libmnl = "${OSS_LAYER_ARCH}"

PR:pn-libndp = "r0"
PACKAGE_ARCH:pn-libndp = "${OSS_LAYER_ARCH}"

PR:pn-libnewt = "r0"
PACKAGE_ARCH:pn-libnewt = "${OSS_LAYER_ARCH}"

PR:pn-libnl = "r0"
PACKAGE_ARCH:pn-libnl = "${OSS_LAYER_ARCH}"

PR:pn-libnsl2 = "r0"
PACKAGE_ARCH:pn-libnsl2 = "${OSS_LAYER_ARCH}"

PR:pn-libnss-mdns = "r1"
PACKAGE_ARCH:pn-libnss-mdns = "${OSS_LAYER_ARCH}"

PR:pn-liboauth = "r0"
PACKAGE_ARCH:pn-liboauth = "${OSS_LAYER_ARCH}"

PR:pn-libogg = "r0"
PACKAGE_ARCH:pn-libogg = "${OSS_LAYER_ARCH}"

PR:pn-libol = "r0"
PACKAGE_ARCH:pn-libol = "${OSS_LAYER_ARCH}"

PR:pn-libomxil = "r0"
PACKAGE_ARCH:pn-libomxil = "${OSS_LAYER_ARCH}"

PR:pn-libopus = "r0"
PACKAGE_ARCH:pn-libopus = "${OSS_LAYER_ARCH}"

PR:pn-libpam = "r0"
PACKAGE_ARCH:pn-libpam = "${OSS_LAYER_ARCH}"

PR:pn-libpcap = "r1"
PACKAGE_ARCH:pn-libpcap = "${OSS_LAYER_ARCH}"

PR:pn-libpciaccess = "r0"
PACKAGE_ARCH:pn-libpciaccess = "${OSS_LAYER_ARCH}"

PR:pn-libpcre = "r0"
PACKAGE_ARCH:pn-libpcre = "${OSS_LAYER_ARCH}"

PR:pn-libpcre2 = "r0"
PACKAGE_ARCH:pn-libpcre2 = "${OSS_LAYER_ARCH}"

PR:pn-libpng = "r0"
PACKAGE_ARCH:pn-libpng = "${OSS_LAYER_ARCH}"

PR:pn-libpsl = "r0"
PACKAGE_ARCH:pn-libpsl = "${OSS_LAYER_ARCH}"

PR:pn-libpthread-stubs = "r0"
PACKAGE_ARCH:pn-libpthread-stubs = "${OSS_LAYER_ARCH}"

PR:pn-libsamplerate0 = "r1"
PACKAGE_ARCH:pn-libsamplerate0 = "${OSS_LAYER_ARCH}"

PR:pn-libsdl = "r3"
PACKAGE_ARCH:pn-libsdl = "${OSS_LAYER_ARCH}"

PR:pn-libsdl-image = "r0"
PACKAGE_ARCH:pn-libsdl-image = "${OSS_LAYER_ARCH}"

PR:pn-libsdl-ttf = "r0"
PACKAGE_ARCH:pn-libsdl-ttf = "${OSS_LAYER_ARCH}"

PR:pn-libseccomp = "r0"
PACKAGE_ARCH:pn-libseccomp = "${OSS_LAYER_ARCH}"

PR:pn-libsndfile1 = "r0"
PACKAGE_ARCH:pn-libsndfile1 = "${OSS_LAYER_ARCH}"

PR:pn-libsolv = "r0"
PACKAGE_ARCH:pn-libsolv = "${OSS_LAYER_ARCH}"

PR:pn-libsoup = "r0"
PACKAGE_ARCH:pn-libsoup = "${OSS_LAYER_ARCH}"

PR:pn-libsoup-2.4 = "r1"
PACKAGE_ARCH:pn-libsoup-2.4 = "${OSS_LAYER_ARCH}"

PR:pn-libstd-rs = "r0"
PACKAGE_ARCH:pn-libstd-rs = "${OSS_LAYER_ARCH}"

PR:pn-libtasn1 = "r1"
PACKAGE_ARCH:pn-libtasn1 = "${OSS_LAYER_ARCH}"

PR:pn-libsoup-2.4 = "r1"
PACKAGE_ARCH:pn-libsoup-2.4 = "${OSS_LAYER_ARCH}"

PR:pn-libtheora = "r1"
PACKAGE_ARCH:pn-libtheora = "${OSS_LAYER_ARCH}"

PR:pn-libtinyxml = "r5"
PACKAGE_ARCH:pn-libtinyxml = "${OSS_LAYER_ARCH}"

PR:pn-libtinyxml2 = "r0"
PACKAGE_ARCH:pn-libtinyxml2 = "${OSS_LAYER_ARCH}"

PR:pn-libtirpc = "r0"
PACKAGE_ARCH:pn-libtirpc = "${OSS_LAYER_ARCH}"

PR:pn-libtool = "r0"
PACKAGE_ARCH:pn-libtool = "${OSS_LAYER_ARCH}"

PR:pn-libtool-cross = "r0"
PACKAGE_ARCH:pn-libtool-cross = "${OSS_LAYER_ARCH}"

PR:pn-libunistring = "r0"
PACKAGE_ARCH:pn-libunistring = "${OSS_LAYER_ARCH}"

PR:pn-libunwind = "r0"
PACKAGE_ARCH:pn-libunwind = "${OSS_LAYER_ARCH}"

PR:pn-liburcu = "r0"
PACKAGE_ARCH:pn-liburcu = "${OSS_LAYER_ARCH}"

PR:pn-libusb1 = "r0"
PACKAGE_ARCH:pn-libusb1 = "${OSS_LAYER_ARCH}"

PR:pn-libuv = "r0"
PACKAGE_ARCH:pn-libuv = "${OSS_LAYER_ARCH}"

PR:pn-libvorbis = "r0"
PACKAGE_ARCH:pn-libvorbis = "${OSS_LAYER_ARCH}"

PR:pn-libvpx = "r0"
PACKAGE_ARCH:pn-libvpx = "${OSS_LAYER_ARCH}"

PR:pn-libwebp = "r0"
PACKAGE_ARCH:pn-libwebp = "${OSS_LAYER_ARCH}"

PR:pn-libwebsockets = "r0"
PACKAGE_ARCH:pn-libwebsockets = "${OSS_LAYER_ARCH}"

PR:pn-libxcrypt = "r0"
PACKAGE_ARCH:pn-libxcrypt = "${OSS_LAYER_ARCH}"

PR:pn-libxkbcommon = "r0"
PACKAGE_ARCH:pn-libxkbcommon = "${OSS_LAYER_ARCH}"

PR:pn-libxml2 = "r0"
PACKAGE_ARCH:pn-libxml2 = "${OSS_LAYER_ARCH}"

PR:pn-libxslt = "r0"
PACKAGE_ARCH:pn-libxslt = "${OSS_LAYER_ARCH}"

PR:pn-libzip = "r0"
PACKAGE_ARCH:pn-libzip = "${OSS_LAYER_ARCH}"

PR:pn-lighttpd = "r2"
PACKAGE_ARCH:pn-lighttpd = "${OSS_LAYER_ARCH}"

PR:pn-linenoise = "r1"
PACKAGE_ARCH:pn-linenoise = "${OSS_LAYER_ARCH}"

PR:pn-linux-libc-headers = "r1"
PACKAGE_ARCH:pn-linux-libc-headers = "${OSS_LAYER_ARCH}"

PR:pn-log4c = "r0"
PACKAGE_ARCH:pn-log4c = "${OSS_LAYER_ARCH}"

PR:pn-logrotate = "r1"
PACKAGE_ARCH:pn-logrotate = "${OSS_LAYER_ARCH}"

PR:pn-lsof = "r0"
PACKAGE_ARCH:pn-lsof = "${OSS_LAYER_ARCH}"

PR:pn-lttng-ust = "r0"
PACKAGE_ARCH:pn-lttng-ust = "${OSS_LAYER_ARCH}"

PR:pn-lua = "r0"
PACKAGE_ARCH:pn-lua = "${OSS_LAYER_ARCH}"

PR:pn-lvm2 = "r0"
PACKAGE_ARCH:pn-lvm2 = "${OSS_LAYER_ARCH}"

PR:pn-lz4 = "r0"
PACKAGE_ARCH:pn-lz4 = "${OSS_LAYER_ARCH}"

PR:pn-lzo = "r0"
PACKAGE_ARCH:pn-lzo = "${OSS_LAYER_ARCH}"

PR:pn-m4 = "r2"
PACKAGE_ARCH:pn-m4 = "${OSS_LAYER_ARCH}"

PR:pn-mbedtls = "r0"
PACKAGE_ARCH:pn-mbedtls = "${OSS_LAYER_ARCH}"

PR:pn-mdns = "r0"
PACKAGE_ARCH:pn-mdns = "${OSS_LAYER_ARCH}"

PR:pn-minizip = "r0"
PACKAGE_ARCH:pn-minizip = "${OSS_LAYER_ARCH}"

PR:pn-mongoose = "r0"
PACKAGE_ARCH:pn-mongoose = "${OSS_LAYER_ARCH}"

PR:pn-msgpack-c = "r0"
PACKAGE_ARCH:pn-msgpack-c = "${OSS_LAYER_ARCH}"

PR:pn-mtdev = "r0"
PACKAGE_ARCH:pn-mtdev = "${OSS_LAYER_ARCH}"

PR:pn-mtd-utils = "r1"
PACKAGE_ARCH:pn-mtd-utils = "${OSS_LAYER_ARCH}"

PR:pn-msgpack-c = "r0"
PACKAGE_ARCH:pn-msgpack-c = "${OSS_LAYER_ARCH}"

PR:pn-nanomsg = "r0"
PACKAGE_ARCH:pn-nanomsg = "${OSS_LAYER_ARCH}"

PR:pn-ncurses = "r1"
PACKAGE_ARCH:pn-ncurses = "${OSS_LAYER_ARCH}"

PR:pn-ndisc6 = "r0"
PACKAGE_ARCH:pn-ndisc6 = "${OSS_LAYER_ARCH}"

PR:pn-ne10 = "r0"
PACKAGE_ARCH:pn-ne10 = "${OSS_LAYER_ARCH}"

PR:pn-netbase = "r0"
PACKAGE_ARCH:pn-netbase = "${OSS_LAYER_ARCH}"

PR:pn-nettle = "r0"
PACKAGE_ARCH:pn-nettle = "${OSS_LAYER_ARCH}"

PR:pn-networkmanager = "r5"
PACKAGE_ARCH:pn-networkmanager = "${OSS_LAYER_ARCH}"

PR:pn-nghttp2 = "r1"
PACKAGE_ARCH:pn-nghttp2 = "${OSS_LAYER_ARCH}"

PR:pn-nopoll = "r0"
PACKAGE_ARCH:pn-nopoll = "${OSS_LAYER_ARCH}"

PR:pn-nspr = "r0"
PACKAGE_ARCH:pn-nspr = "${OSS_LAYER_ARCH}"

PR:pn-nss = "r0"
PACKAGE_ARCH:pn-nss = "${OSS_LAYER_ARCH}"

PR:pn-openjpeg = "r0"
PACKAGE_ARCH:pn-openjpeg = "${OSS_LAYER_ARCH}"

PR:pn-openssh = "r0"
PACKAGE_ARCH:pn-openssh = "${OSS_LAYER_ARCH}"

PR:pn-openssl = "r0"
PACKAGE_ARCH:pn-openssl = "${OSS_LAYER_ARCH}"

PR:pn-openssl-1.1.1l = "r0"
PACKAGE_ARCH:pn-openssl-1.1.1l = "${OSS_LAYER_ARCH}"

PR:pn-opkg = "r1"
PACKAGE_ARCH:pn-opkg = "${OSS_LAYER_ARCH}"

PR:pn-opkg-arch-config = "r1"
PACKAGE_ARCH:pn-opkg-arch-config = "${OSS_LAYER_ARCH}"

PR:pn-opkg-utils = "r1"
PACKAGE_ARCH:pn-opkg-utils = "${OSS_LAYER_ARCH}"

PR:pn-orc = "r0"
PACKAGE_ARCH:pn-orc = "${OSS_LAYER_ARCH}"

PR:pn-perl = "r0"
PACKAGE_ARCH:pn-perl = "${OSS_LAYER_ARCH}"

PR:pn-pixman = "r0"
PACKAGE_ARCH:pn-pixman = "${OSS_LAYER_ARCH}"

PR:pn-popt = "r0"
PACKAGE_ARCH:pn-popt = "${OSS_LAYER_ARCH}"

PR:pn-procps = "r1"
PACKAGE_ARCH:pn-procps = "${OSS_LAYER_ARCH}"

PR:pn-protobuf = "r0"
PACKAGE_ARCH:pn-protobuf = "${OSS_LAYER_ARCH}"

PR:pn-protobuf-c = "r0"
PACKAGE_ARCH:pn-protobuf-c = "${OSS_LAYER_ARCH}"

#PR:pn-pulseaudio = "r0"
#PACKAGE_ARCH:pn-pulseaudio =  "${OSS_LAYER_ARCH}"

PR:pn-python = "r0"
PACKAGE_ARCH:pn-python = "${OSS_LAYER_ARCH}"

PR:pn-python3 = "r1"
PACKAGE_ARCH:pn-python3 = "${OSS_LAYER_ARCH}"

PR:pn-python3-dbus = "r0"
PACKAGE_ARCH:pn-python3-dbus = "${OSS_LAYER_ARCH}"

PR:pn-qrencode = "r0"
PACKAGE_ARCH:pn-qrencode = "${OSS_LAYER_ARCH}"

PR:pn-rapidjson = "r0"
PACKAGE_ARCH:pn-rapidjson = "${OSS_LAYER_ARCH}"

PR:pn-rdkperf = "r0"
PACKAGE_ARCH:pn-rdkperf = "${OSS_LAYER_ARCH}"

PV:pn-rdm = "1.0.1"
PR:pn-rdm = "r1"
PACKAGE_ARCH:pn-rdm = "${OSS_LAYER_ARCH}"

PR:pn-re2 = "r0"
PACKAGE_ARCH:pn-re2 = "${OSS_LAYER_ARCH}"

PR:pn-readline = "r9"
PACKAGE_ARCH:pn-readline = "${OSS_LAYER_ARCH}"

PR:pn-redis = "r1"
PACKAGE_ARCH:pn-redis = "${OSS_LAYER_ARCH}"

PR:pn-run-postinsts = "r10"
PACKAGE_ARCH:pn-run-postinsts = "${OSS_LAYER_ARCH}"

PR:pn-safec = "r0"
PACKAGE_ARCH:pn-safec = "${OSS_LAYER_ARCH}"

PR:pn-safec-common-wrapper = "r0"
PACKAGE_ARCH:pn-safec-common-wrapper = "${OSS_LAYER_ARCH}"

PR:pn-sbc = "r0"
PACKAGE_ARCH:pn-sbc = "${OSS_LAYER_ARCH}"

PR:pn-shadow = "r0"
PACKAGE_ARCH:pn-shadow = "${OSS_LAYER_ARCH}"

PR:pn-shadow-securetty = "r3"
PACKAGE_ARCH:pn-shadow-securetty = "${OSS_LAYER_ARCH}"

PR:pn-shadow-sysroot = "r3"
PACKAGE_ARCH:pn-shadow-sysroot = "${OSS_LAYER_ARCH}"

PR:pn-shared-mime-info = "r0"
PACKAGE_ARCH:pn-shared-mime-info = "${OSS_LAYER_ARCH}"

PR:pn-slang = "r0"
PACKAGE_ARCH:pn-slang = "${OSS_LAYER_ARCH}"

PR:pn-smcroute = "r0"
PACKAGE_ARCH:pn-smcroute = "${OSS_LAYER_ARCH}"

PR:pn-speex = "r0"
PACKAGE_ARCH:pn-speex = "${OSS_LAYER_ARCH}"

PR:pn-speexdsp = "r0"
PACKAGE_ARCH:pn-speexdsp = "${OSS_LAYER_ARCH}"

PR:pn-sqlite = "r7"
PACKAGE_ARCH:pn-sqlite = "${OSS_LAYER_ARCH}"

PR:pn-sqlite3 = "r1"
PACKAGE_ARCH:pn-sqlite3 = "${OSS_LAYER_ARCH}"

PR:pn-strace = "r0"
PACKAGE_ARCH:pn-strace = "${OSS_LAYER_ARCH}"

PR:pn-stunnel = "r2"
PACKAGE_ARCH:pn-stunnel = "${OSS_LAYER_ARCH}"

PR:pn-sysfsutils = "r6"
PACKAGE_ARCH:pn-sysfsutils = "${OSS_LAYER_ARCH}"

PR:pn-syslog-ng = "r2"
PACKAGE_ARCH:pn-syslog-ng = "${OSS_LAYER_ARCH}"

PR:pn-systemd = "r10"
PACKAGE_ARCH:pn-systemd = "${OSS_LAYER_ARCH}"

PR:pn-systemd-serialgetty = "r5"
PACKAGE_ARCH:pn-systemd-serialgetty = "${OSS_LAYER_ARCH}"

PR:pn-taglib = "r0"
PACKAGE_ARCH:pn-taglib = "${OSS_LAYER_ARCH}"

PR:pn-tcpdump = "r0"
PACKAGE_ARCH:pn-tcpdump = "${OSS_LAYER_ARCH}"

PR:pn-tcp-wrappers = "r10"
PACKAGE_ARCH:pn-tcp-wrappers = "${OSS_LAYER_ARCH}"

PR:pn-tiff = "r0"
PACKAGE_ARCH:pn-tiff = "${OSS_LAYER_ARCH}"

PR:pn-trace-cmd = "r0"
PACKAGE_ARCH:pn-trace-cmd = "${OSS_LAYER_ARCH}"

PR:pn-tremor = "r0"
PACKAGE_ARCH:pn-tremor = "${OSS_LAYER_ARCH}"

PR:pn-trower-base64 = "r0"
PACKAGE_ARCH:pn-trower-base64 = "${OSS_LAYER_ARCH}"

PR:pn-tzdata = "r1"
PACKAGE_ARCH:pn-tzdata = "${OSS_LAYER_ARCH}"

PR:pn-udev-extraconf = "r1"
PACKAGE_ARCH:pn-udev-extraconf = "${OSS_LAYER_ARCH}"

PR:pn-unzip = "r5"
PACKAGE_ARCH:pn-unzip = "${OSS_LAYER_ARCH}"

PR:pn-update-rc.d = "r0"
PACKAGE_ARCH:pn-update-rc.d = "${OSS_LAYER_ARCH}"

PR:pn-util-linux = "r0"
PACKAGE_ARCH:pn-util-linux = "${OSS_LAYER_ARCH}"

PR:pn-util-linux-libuuid = "r0"
PACKAGE_ARCH:pn-util-linux-libuuid = "${OSS_LAYER_ARCH}"

PR:pn-util-macros = "r0"
PACKAGE_ARCH:pn-util-macros = "${OSS_LAYER_ARCH}"

PR:pn-vala = "r0"
PACKAGE_ARCH:pn-vala = "${OSS_LAYER_ARCH}"

PR:pn-vmtouch = "r0"
PACKAGE_ARCH:pn-vmtouch = "${OSS_LAYER_ARCH}"

PR:pn-wayland = "r0"
PACKAGE_ARCH:pn-wayland = "${OSS_LAYER_ARCH}"

PR:pn-wayland-protocols = "r1"
PACKAGE_ARCH:pn-wayland-protocols = "${OSS_LAYER_ARCH}"

PR:pn-websocketpp = "r0"
PACKAGE_ARCH:pn-websocketpp = "${OSS_LAYER_ARCH}"

PR:pn-wireless-regdb = "r0"
PACKAGE_ARCH:pn-wireless-regdb = "${OSS_LAYER_ARCH}"

PR:pn-wireless-tools = "r0"
PACKAGE_ARCH:pn-wireless-tools = "${OSS_LAYER_ARCH}"
PR:pn-woff2 = "r0"
PACKAGE_ARCH:pn-woff2 = "${OSS_LAYER_ARCH}"

PR:pn-wpa-supplicant = "r7"
PACKAGE_ARCH:pn-wpa-supplicant = "${OSS_LAYER_ARCH}"

PR:pn-xkeyboard-config = "r0"
PACKAGE_ARCH:pn-xkeyboard-config = "${OSS_LAYER_ARCH}"

PR:pn-xmlsec1 = "r0"
PACKAGE_ARCH:pn-xmlsec1 = "${OSS_LAYER_ARCH}"

PR:pn-xz = "r0"
PACKAGE_ARCH:pn-xz = "${OSS_LAYER_ARCH}"

PR:pn-yajl = "r0"
PACKAGE_ARCH:pn-yajl = "${OSS_LAYER_ARCH}"

PR:pn-zlib = "r0"
PACKAGE_ARCH:pn-zlib = "${OSS_LAYER_ARCH}"

PR:pn-zstd = "r0"
PACKAGE_ARCH:pn-zstd = "${OSS_LAYER_ARCH}"
