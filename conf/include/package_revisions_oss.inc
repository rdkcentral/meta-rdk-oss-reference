# PREFERRED VERSION settings

PREFERRED_VERSION_civetweb = "1.10+git%"
PREFERRED_VERSION_gmp = "4.2.1"
PREFERRED_VERSION_gupnp = "0.20.10%"
PREFERRED_VERSION_jsoncpp = "1.8.4"
PREFERRED_VERSION_jquery = "1.0.0"
PREFERRED_VERSION_libarchive = "3.6.1"
PREFERRED_VERSION_log4c = "1.2.3"
PREFERRED_VERSION_nopoll = "0.3.2.b232"
PREFERRED_VERSION_wpa-supplicant = "2.10"
PREFERRED_VERSION_libunwind = "1.3.1"
PREFERRED_VERSION_libvpx = "1.12.0"
PREFERRED_VERSION_coreutils = "6.9"

#To resolve gettext native version mismatch due to layer priority
PREFERRED_VERSION_gettext-native = "0.20.1"
PREFERRED_VERSION_readline-native = "8.0"
PREFERRED_VERSION_nativesdk-readline = "8.0"
PREFERRED_VERSION_bluez5 = "5.48"

# Workaround to build allarch packags as oss arch
MULTILIB_VARIANTS_pn-alsa-topology-conf = " multilib "
MULTILIB_VARIANTS_pn-alsa-ucm-conf = " multilib "
MULTILIB_VARIANTS_pn-autoconf-archive = " multilib "
MULTILIB_VARIANTS_pn-ca-certificates = " multilib "
MULTILIB_VARIANTS_pn-iso-codes = " multilib "
MULTILIB_VARIANTS_pn-run-postinsts = " multilib "
MULTILIB_VARIANTS_pn-tzdata = " multilib "
MULTILIB_VARIANTS_pn-update-rc.d = " multilib "
MULTILIB_VARIANTS_pn-wayland-protocols = " multilib "
MULTILIB_VARIANTS_pn-wireless-regdb = " multilib "
MULTILIB_VARIANTS_pn-liberation-fonts = " multilib "

# Package revisions and architecture configurations
PR_pn-acl = "r0"
PACKAGE_ARCH_pn-acl = "${OSS_LAYER_ARCH}"

PR_pn-alsa-lib = "r0"
PACKAGE_ARCH_pn-alsa-lib = "${OSS_LAYER_ARCH}"

PR_pn-alsa-state = "r5"
PACKAGE_ARCH_pn-alsa-state = "${OSS_LAYER_ARCH}"

PR_pn-alsa-plugins = "r0"
PACKAGE_ARCH_pn-alsa-plugins =  "${OSS_LAYER_ARCH}"

PR_pn-alsa-topology-conf = "r0"
PACKAGE_ARCH_pn-alsa-topology-conf = "${OSS_LAYER_ARCH}"

PR_pn-alsa-ucm-conf = "r0"
PACKAGE_ARCH_pn-alsa-ucm-conf = "${OSS_LAYER_ARCH}"

PR_pn-alsa-utils = "r0"
PACKAGE_ARCH_pn-alsa-utils = "${OSS_LAYER_ARCH}"

PR_pn-alsa-utils-scripts = "r0"
PACKAGE_ARCH_pn-alsa-utils-scripts = "${OSS_LAYER_ARCH}"

PR_pn-apparmor = "r0"
PACKAGE_ARCH_pn-apparmor = "${OSS_LAYER_ARCH}"

PR_pn-atk = "r0"
PACKAGE_ARCH_pn-atk = "${OSS_LAYER_ARCH}"

PR_pn-attr = "r0"
PACKAGE_ARCH_pn-attr = "${OSS_LAYER_ARCH}"

PR_pn-autoconf-archive = "r0"
PACKAGE_ARCH_pn-autoconf-archive = "${OSS_LAYER_ARCH}"

PR_pn-avahi = "r1"
PACKAGE_ARCH_pn-avahi = "${OSS_LAYER_ARCH}"

PR_pn-base-files = "r89"
PACKAGE_ARCH_pn-base-files = "${OSS_LAYER_ARCH}"

PR_pn-base-passwd = "r0"
PACKAGE_ARCH_pn-base-passwd = "${OSS_LAYER_ARCH}"

PR_pn-bash = "r0"
PACKAGE_ARCH_pn-bash = "${OSS_LAYER_ARCH}"

PR_pn-bash-completion = "r0"
PACKAGE_ARCH_pn-bash-completion = "${OSS_LAYER_ARCH}"

PR_pn-bind = "r0"
PACKAGE_ARCH_pn-bind = "${OSS_LAYER_ARCH}"

PR_pn-boost = "r0"
PACKAGE_ARCH_pn-boost = "${OSS_LAYER_ARCH}"

PR_pn-breakpad = "r1"
PACKAGE_ARCH_pn-breakpad = "${OSS_LAYER_ARCH}"

PR_pn-breakpad-wrapper = "r0"
PACKAGE_ARCH_pn-breakpad-wrapper = "${OSS_LAYER_ARCH}"

PR_pn-brotli = "r0"
PACKAGE_ARCH_pn-brotli = "${OSS_LAYER_ARCH}"

PR_pn-busybox = "r1"
PACKAGE_ARCH_pn-busybox = "${OSS_LAYER_ARCH}"

PR_pn-bzip2 = "r0"
PACKAGE_ARCH_pn-bzip2 = "${OSS_LAYER_ARCH}"

PR_pn-ca-certificates = "r2"
PACKAGE_ARCH_pn-ca-certificates = "${OSS_LAYER_ARCH}"

PR_pn-c-ares = "r0"
PACKAGE_ARCH_pn-c-ares = "${OSS_LAYER_ARCH}"

PR_pn-civetweb = "r0"
PACKAGE_ARCH_pn-civetweb = "${OSS_LAYER_ARCH}"

PR_pn-cjson = "r0"
PACKAGE_ARCH_pn-cjson = "${OSS_LAYER_ARCH}"

PR_pn-coreutils = "r0"
PACKAGE_ARCH_pn-coreutils = "${OSS_LAYER_ARCH}"

PR_pn-cracklib = "r0"
PACKAGE_ARCH_pn-cracklib = "${OSS_LAYER_ARCH}"

PR_pn-crun = "r0"
PACKAGE_ARCH_pn-crun = "${OSS_LAYER_ARCH}"

PR_pn-ctemplate = "r3"
PACKAGE_ARCH_pn-ctemplate = "${OSS_LAYER_ARCH}"

PR_pn-cunit = "r0"
PACKAGE_ARCH_pn-cunit = "${OSS_LAYER_ARCH}"

PR_pn-curl = "r0"
PACKAGE_ARCH_pn-curl = "${OSS_LAYER_ARCH}"

PR_pn-db = "r1"
PACKAGE_ARCH_pn-db = "${OSS_LAYER_ARCH}"

PR_pn-dbus = "r0"
PACKAGE_ARCH_pn-dbus = "${OSS_LAYER_ARCH}"

PR_pn-dbus-glib = "r0"
PACKAGE_ARCH_pn-dbus-glib = "${OSS_LAYER_ARCH}"

PR_pn-dibbler= "r1"
PACKAGE_ARCH_pn-dibbler = "${OSS_LAYER_ARCH}"

PR_pn-dnsmasq = "r4"
PACKAGE_ARCH_pn-dnsmasq = "${OSS_LAYER_ARCH}"

PR_pn-dosfstools = "r0"
PACKAGE_ARCH_pn-dosfstools = "${OSS_LAYER_ARCH}"

PR_pn-e2fsprogs = "r0"
PACKAGE_ARCH_pn-e2fsprogs = "${OSS_LAYER_ARCH}"

PR_pn-ebtables = "r4"
PACKAGE_ARCH_pn-ebtables = "${OSS_LAYER_ARCH}"

PR_pn-elfutils = "r0"
PACKAGE_ARCH_pn-elfutils = "${OSS_LAYER_ARCH}"

PR_pn-evtest = "r0"
PACKAGE_ARCH_pn-evtest = "${OSS_LAYER_ARCH}"

PR_pn-expat = "r0"
PACKAGE_ARCH_pn-expat = "${OSS_LAYER_ARCH}"

PR_pn-fcgi = "r0"
PACKAGE_ARCH_pn-fcgi = "${OSS_LAYER_ARCH}"

PR_pn-file = "r0"
PACKAGE_ARCH_pn-file = "${OSS_LAYER_ARCH}"

PR_pn-findutils = "r0"
PACKAGE_ARCH_pn-findutils = "${OSS_LAYER_ARCH}"

PR_pn-flac = "r0"
PACKAGE_ARCH_pn-flac = "${OSS_LAYER_ARCH}"

PR_pn-flex = "r0"
PACKAGE_ARCH_pn-flex = "${OSS_LAYER_ARCH}"

PR_pn-fontconfig = "r0"
PACKAGE_ARCH_pn-fontconfig = "${OSS_LAYER_ARCH}"

PR_pn-freetype = "r0"
PACKAGE_ARCH_pn-freetype = "${OSS_LAYER_ARCH}"

PR_pn-fribidi = "r0"
PACKAGE_ARCH_pn-fribidi = "${OSS_LAYER_ARCH}"

PR_pn-gawk = "r2"
PACKAGE_ARCH_pn-gawk = "${OSS_LAYER_ARCH}"

PR_pn-gcc-runtime = "r0"
PACKAGE_ARCH_pn-gcc-runtime = "${OSS_LAYER_ARCH}"

PR_pn-gcc-sanitizers = "r0"
PACKAGE_ARCH_pn-gcc-sanitizers = "${OSS_LAYER_ARCH}"

PR_pn-sed = "r0"
PACKAGE_ARCH_pn-sed = "${OSS_LAYER_ARCH}"

PR_pn-gdbm = "r4"
PACKAGE_ARCH_pn-gdbm = "${OSS_LAYER_ARCH}"

PR_pn-gdk-pixbuf = "r0"
PACKAGE_ARCH_pn-gdk-pixbuf = "${OSS_LAYER_ARCH}"

PR_pn-gettext = "r6"
PACKAGE_ARCH_pn-gettext = "${OSS_LAYER_ARCH}"

PR_pn-gflags = "r0"
PACKAGE_ARCH_pn-gflags = "${OSS_LAYER_ARCH}"

PR_pn-glib-2.0 = "r1"
PACKAGE_ARCH_pn-glib-2.0 = "${OSS_LAYER_ARCH}"

PR_pn-glibc = "r1"
PACKAGE_ARCH_pn-glibc = "${OSS_LAYER_ARCH}"

PR_pn-glibc-locale = "r0"
PACKAGE_ARCH_pn-glibc-locale = "${OSS_LAYER_ARCH}"

PR_pn-glibc-mtrace = "r0"
PACKAGE_ARCH_pn-glibc-mtrace = "${OSS_LAYER_ARCH}"

PR_pn-glib-networking = "r0"
PACKAGE_ARCH_pn-glib-networking = "${OSS_LAYER_ARCH}"


PR_pn-glib-openssl = "r0"
PACKAGE_ARCH_pn-glib-openssl = "${OSS_LAYER_ARCH}"

PR_pn-gmp = "r0"
PACKAGE_ARCH_pn-gmp = "${OSS_LAYER_ARCH}"

PR_pn-gnutls = "r0"
PACKAGE_ARCH_pn-gnutls = "${OSS_LAYER_ARCH}"

PR_pn-gobject-introspection = "r0"
PACKAGE_ARCH_pn-gobject-introspection = "${OSS_LAYER_ARCH}"

PR_pn-googletest = "r0"
PACKAGE_ARCH_pn-googletest = "${OSS_LAYER_ARCH}"

PR_pn-graphite2 = "r0"
PACKAGE_ARCH_pn-graphite2 = "${OSS_LAYER_ARCH}"

PR_pn-grpc = "r0"
PACKAGE_ARCH_pn-grpc = "${OSS_LAYER_ARCH}"

PR_pn-gssdp = "r0"
PACKAGE_ARCH_pn-gssdp = "${OSS_LAYER_ARCH}"

PR_pn-gupnp = "r1"
PACKAGE_ARCH_pn-gupnp = "${OSS_LAYER_ARCH}"

PR_pn-harfbuzz = "r0"
PACKAGE_ARCH_pn-harfbuzz = "${OSS_LAYER_ARCH}"

PR_pn-heaptrack = "r0"
PACKAGE_ARCH_pn-heaptrack = "${OSS_LAYER_ARCH}"

PR_pn-hiredis = "r0"
PACKAGE_ARCH_pn-hiredis = "${OSS_LAYER_ARCH}"

PR_pn-icu = "r0"
PACKAGE_ARCH_pn-icu = "${OSS_LAYER_ARCH}"

PR_pn-initscripts = "r155"
PACKAGE_ARCH_pn-initscripts = "${OSS_LAYER_ARCH}"

PR_pn-iperf3 = "r0"
PACKAGE_ARCH_pn-iperf3 = "${OSS_LAYER_ARCH}"

PR_pn-iptables = "r0"
PACKAGE_ARCH_pn-iptables = "${OSS_LAYER_ARCH}"

PR_pn-iso-codes = "r0"
PACKAGE_ARCH_pn-iso-codes = "${OSS_LAYER_ARCH}"

PR_pn-iw = "r0"
PACKAGE_ARCH_pn-iw = "${OSS_LAYER_ARCH}"

PR_pn-jansson = "r0"
PACKAGE_ARCH_pn-jansson = "${OSS_LAYER_ARCH}"

PR_pn-jquery = "r3"
PACKAGE_ARCH_pn-jquery = "${OSS_LAYER_ARCH}"

PR_pn-json-c = "r0"
PACKAGE_ARCH_pn-json-c = "${OSS_LAYER_ARCH}"

PR_pn-jsoncpp = "r0"
PACKAGE_ARCH_pn-jsoncpp = "${OSS_LAYER_ARCH}"

PR_pn-jsonrpc = "r0"
PACKAGE_ARCH_pn-jsonrpc = "${OSS_LAYER_ARCH}"

PR_pn-kbd = "r0"
PACKAGE_ARCH_pn-kbd = "${OSS_LAYER_ARCH}"

PR_pn-keyutils = "r0"
PACKAGE_ARCH_pn-keyutils = "${OSS_LAYER_ARCH}"

PR_pn-kmod = "r0"
PACKAGE_ARCH_pn-kmod = "${OSS_LAYER_ARCH}"

PR_pn-lcms = "r0"
PACKAGE_ARCH_pn-lcms = "${OSS_LAYER_ARCH}"

PR_pn-libaio = "r0"
PACKAGE_ARCH_pn-libaio = "${OSS_LAYER_ARCH}"

PR_pn-libarchive = "r0"
PACKAGE_ARCH_pn-libarchive = "${OSS_LAYER_ARCH}"

PR_pn-libatomic-ops = "r0"
PACKAGE_ARCH_pn-libatomic-ops = "${OSS_LAYER_ARCH}"

PR_pn-libbsd = "r0"
PACKAGE_ARCH_pn-libbsd = "${OSS_LAYER_ARCH}"

PR_pn-libcap = "r0"
PACKAGE_ARCH_pn-libcap = "${OSS_LAYER_ARCH}"

PR_pn-libcap-ng = "r0"
PACKAGE_ARCH_pn-libcap-ng = "${OSS_LAYER_ARCH}"

PR_pn-libcgroup = "r0"
PACKAGE_ARCH_pn-libcgroup = "${OSS_LAYER_ARCH}"

PR_pn-libcheck = "r0"
PACKAGE_ARCH_pn-libcheck = "${OSS_LAYER_ARCH}"

PR_pn-libcroco = "r0"
PACKAGE_ARCH_pn-libcroco = "${OSS_LAYER_ARCH}"

PR_pn-libdaemon = "r0"
PACKAGE_ARCH_pn-libdaemon = "${OSS_LAYER_ARCH}"

PR_pn-libdash = "r1"
PACKAGE_ARCH_pn-libdash = "${OSS_LAYER_ARCH}"

PR_pn-libdwarf = "r0"
PACKAGE_ARCH_pn-libdwarf = "${OSS_LAYER_ARCH}"

PR_pn-liberation-fonts = "r0"
PACKAGE_ARCH_pn-liberation-fonts = "${OSS_LAYER_ARCH}"

PR_pn-libev = "r0"
PACKAGE_ARCH_pn-libev = "${OSS_LAYER_ARCH}"

PR_pn-libevdev = "r0"
PACKAGE_ARCH_pn-libevdev = "${OSS_LAYER_ARCH}"

PR_pn-libevent = "r0"
PACKAGE_ARCH_pn-libevent = "${OSS_LAYER_ARCH}"

PR_pn-libexif = "r0"
PACKAGE_ARCH_pn-libexif = "${OSS_LAYER_ARCH}"

PR_pn-libffi = "r0"
PACKAGE_ARCH_pn-libffi = "${OSS_LAYER_ARCH}"

PR_pn-libgcc = "r0"
PACKAGE_ARCH_pn-libgcc = "${OSS_LAYER_ARCH}"

PR_pn-libgcc-initial = "r0"
PACKAGE_ARCH_pn-libgcc-initial = "${OSS_LAYER_ARCH}"

PR_pn-libgcrypt = "r0"
PACKAGE_ARCH_pn-libgcrypt = "${OSS_LAYER_ARCH}"

PR_pn-libgpg-error = "r0"
PACKAGE_ARCH_pn-libgpg-error = "${OSS_LAYER_ARCH}"

PR_pn-libgudev = "r0"
PACKAGE_ARCH_pn-libgudev = "${OSS_LAYER_ARCH}"

PR_pn-libical = "r0"
PACKAGE_ARCH_pn-libical = "${OSS_LAYER_ARCH}"

PR_pn-libidn2 = "r0"
PACKAGE_ARCH_pn-libidn2 = "${OSS_LAYER_ARCH}"

PR_pn-libinput = "r0"
PACKAGE_ARCH_pn-libinput = "${OSS_LAYER_ARCH}"

PR_pn-libjpeg = "r0"
PACKAGE_ARCH_pn-libjpeg = "${OSS_LAYER_ARCH}"

PR_pn-libmanette = "r0"
PACKAGE_ARCH_pn-libmanette = "${OSS_LAYER_ARCH}"

PR_pn-libmicrohttpd = "r0"
PACKAGE_ARCH_pn-libmicrohttpd = "${OSS_LAYER_ARCH}"

PR_pn-libmng = "r0"
PACKAGE_ARCH_pn-libmng = "${OSS_LAYER_ARCH}"

PR_pn-libndp = "r0"
PACKAGE_ARCH_pn-libndp = "${OSS_LAYER_ARCH}"

PR_pn-libnewt = "r0"
PACKAGE_ARCH_pn-libnewt = "${OSS_LAYER_ARCH}"

PR_pn-libnl = "r0"
PACKAGE_ARCH_pn-libnl = "${OSS_LAYER_ARCH}"

PR_pn-libnsl2 = "r0"
PACKAGE_ARCH_pn-libnsl2 = "${OSS_LAYER_ARCH}"

PR_pn-libnss-mdns = "r0"
PACKAGE_ARCH_pn-libnss-mdns = "${OSS_LAYER_ARCH}"

PR_pn-liboauth = "r0"
PACKAGE_ARCH_pn-liboauth = "${OSS_LAYER_ARCH}"

PR_pn-libogg = "r0"
PACKAGE_ARCH_pn-libogg = "${OSS_LAYER_ARCH}"

PR_pn-libol = "r0"
PACKAGE_ARCH_pn-libol = "${OSS_LAYER_ARCH}"

PR_pn-libomxil = "r0"
PACKAGE_ARCH_pn-libomxil = "${OSS_LAYER_ARCH}"

PR_pn-libopus = "r0"
PACKAGE_ARCH_pn-libopus = "${OSS_LAYER_ARCH}"

PR_pn-libpam = "r0"
PACKAGE_ARCH_pn-libpam = "${OSS_LAYER_ARCH}"

PR_pn-libpcap = "r1"
PACKAGE_ARCH_pn-libpcap = "${OSS_LAYER_ARCH}"

PR_pn-libpciaccess = "r0"
PACKAGE_ARCH_pn-libpciaccess = "${OSS_LAYER_ARCH}"

PR_pn-libpcre = "r0"
PACKAGE_ARCH_pn-libpcre = "${OSS_LAYER_ARCH}"

PR_pn-libpcre2 = "r0"
PACKAGE_ARCH_pn-libpcre2 = "${OSS_LAYER_ARCH}"

PR_pn-libpng = "r0"
PACKAGE_ARCH_pn-libpng = "${OSS_LAYER_ARCH}"

PR_pn-libpsl = "r0"
PACKAGE_ARCH_pn-libpsl = "${OSS_LAYER_ARCH}"

PR_pn-libpthread-stubs = "r0"
PACKAGE_ARCH_pn-libpthread-stubs = "${OSS_LAYER_ARCH}"

PR_pn-libsamplerate0 = "r1"
PACKAGE_ARCH_pn-libsamplerate0 = "${OSS_LAYER_ARCH}"

PR_pn-libsdl = "r3"
PACKAGE_ARCH_pn-libsdl = "${OSS_LAYER_ARCH}"

PR_pn-libsdl-image = "r0"
PACKAGE_ARCH_pn-libsdl-image = "${OSS_LAYER_ARCH}"

PR_pn-libsdl-ttf = "r0"
PACKAGE_ARCH_pn-libsdl-ttf = "${OSS_LAYER_ARCH}"

PR_pn-libseccomp = "r0"
PACKAGE_ARCH_pn-libseccomp = "${OSS_LAYER_ARCH}"

PR_pn-libsndfile1 = "r0"
PACKAGE_ARCH_pn-libsndfile1 = "${OSS_LAYER_ARCH}"

PR_pn-libsolv = "r0"
PACKAGE_ARCH_pn-libsolv = "${OSS_LAYER_ARCH}"

PR_pn-libsoup = "r0"
PACKAGE_ARCH_pn-libsoup = "${OSS_LAYER_ARCH}"

PR_pn-libsoup-2.4 = "r1"
PACKAGE_ARCH_pn-libsoup-2.4 = "${OSS_LAYER_ARCH}"

PR_pn-libstd-rs = "r0"
PACKAGE_ARCH_pn-libstd-rs = "${OSS_LAYER_ARCH}"

PR_pn-libtasn1 = "r0"
PACKAGE_ARCH_pn-libtasn1 = "${OSS_LAYER_ARCH}"

PR_pn-libtheora = "r1"
PACKAGE_ARCH_pn-libtheora = "${OSS_LAYER_ARCH}"

PR_pn-libtinyxml = "r5"
PACKAGE_ARCH_pn-libtinyxml = "${OSS_LAYER_ARCH}"

PR_pn-libtinyxml2 = "r0"
PACKAGE_ARCH_pn-libtinyxml2 = "${OSS_LAYER_ARCH}"

PR_pn-libtirpc = "r0"
PACKAGE_ARCH_pn-libtirpc = "${OSS_LAYER_ARCH}"

PR_pn-libtool = "r0"
PACKAGE_ARCH_pn-libtool = "${OSS_LAYER_ARCH}"

PR_pn-libtool-cross = "r0"
PACKAGE_ARCH_pn-libtool-cross = "${OSS_LAYER_ARCH}"

PR_pn-libunistring = "r0"
PACKAGE_ARCH_pn-libunistring = "${OSS_LAYER_ARCH}"

PR_pn-libunwind = "r0"
PACKAGE_ARCH_pn-libunwind = "${OSS_LAYER_ARCH}"

PR_pn-liburcu = "r0"
PACKAGE_ARCH_pn-liburcu = "${OSS_LAYER_ARCH}"

PR_pn-libusb1 = "r0"
PACKAGE_ARCH_pn-libusb1 = "${OSS_LAYER_ARCH}"

PR_pn-libuv = "r0"
PACKAGE_ARCH_pn-libuv = "${OSS_LAYER_ARCH}"

PR_pn-libvorbis = "r0"
PACKAGE_ARCH_pn-libvorbis = "${OSS_LAYER_ARCH}"

PR_pn-libvpx = "r0"
PACKAGE_ARCH_pn-libvpx = "${OSS_LAYER_ARCH}"

PR_pn-libwebp = "r0"
PACKAGE_ARCH_pn-libwebp = "${OSS_LAYER_ARCH}"

PR_pn-libwebsockets = "r1"
PACKAGE_ARCH_pn-libwebsockets = "${OSS_LAYER_ARCH}"

PR_pn-libxcrypt = "r0"
PACKAGE_ARCH_pn-libxcrypt = "${OSS_LAYER_ARCH}"

PR_pn-libxkbcommon = "r0"
PACKAGE_ARCH_pn-libxkbcommon = "${OSS_LAYER_ARCH}"

PR_pn-libxml2 = "r0"
PACKAGE_ARCH_pn-libxml2 = "${OSS_LAYER_ARCH}"

PR_pn-libxslt = "r0"
PACKAGE_ARCH_pn-libxslt = "${OSS_LAYER_ARCH}"

PR_pn-libzip = "r0"
PACKAGE_ARCH_pn-libzip = "${OSS_LAYER_ARCH}"

PR_pn-lighttpd = "r2"
PACKAGE_ARCH_pn-lighttpd = "${OSS_LAYER_ARCH}"

PR_pn-linenoise = "r1"
PACKAGE_ARCH_pn-linenoise = "${OSS_LAYER_ARCH}"

PR_pn-linux-libc-headers = "r1"
PACKAGE_ARCH_pn-linux-libc-headers = "${OSS_LAYER_ARCH}"

PR_pn-log4c = "r0"
PACKAGE_ARCH_pn-log4c = "${OSS_LAYER_ARCH}"

PR:pn-logrotate = "r1"
PACKAGE_ARCH:pn-logrotate = "${OSS_LAYER_ARCH}"

PR_pn-lttng-ust = "r0"
PACKAGE_ARCH_pn-lttng-ust = "${OSS_LAYER_ARCH}"

PR_pn-lua = "r0"
PACKAGE_ARCH_pn-lua = "${OSS_LAYER_ARCH}"

PR_pn-lvm2 = "r0"
PACKAGE_ARCH_pn-lvm2 = "${OSS_LAYER_ARCH}"

PR_pn-lz4 = "r0"
PACKAGE_ARCH_pn-lz4 = "${OSS_LAYER_ARCH}"

PR_pn-lzo = "r0"
PACKAGE_ARCH_pn-lzo = "${OSS_LAYER_ARCH}"

PR_pn-m4 = "r2"
PACKAGE_ARCH_pn-m4 = "${OSS_LAYER_ARCH}"

PR_pn-mbedtls = "r0"
PACKAGE_ARCH_pn-mbedtls = "${OSS_LAYER_ARCH}"

PR_pn-mdns = "r0"
PACKAGE_ARCH_pn-mdns = "${OSS_LAYER_ARCH}"

PR_pn-minizip = "r0"
PACKAGE_ARCH_pn-minizip = "${OSS_LAYER_ARCH}"

PR_pn-mongoose = "r0"
PACKAGE_ARCH_pn-mongoose = "${OSS_LAYER_ARCH}"

PR_pn-msgpack-c = "r0"
PACKAGE_ARCH_pn-msgpack-c = "${OSS_LAYER_ARCH}"

PR_pn-mtdev = "r0"
PACKAGE_ARCH_pn-mtdev = "${OSS_LAYER_ARCH}"

PR_pn-mtd-utils = "r1"
PACKAGE_ARCH_pn-mtd-utils = "${OSS_LAYER_ARCH}"

PR_pn-nanomsg = "r0"
PACKAGE_ARCH_pn-nanomsg = "${OSS_LAYER_ARCH}"

PR_pn-ncurses = "r0"
PACKAGE_ARCH_pn-ncurses = "${OSS_LAYER_ARCH}"

PR_pn-ndisc6 = "r0"
PACKAGE_ARCH_pn-ndisc6 = "${OSS_LAYER_ARCH}"

PR_pn-ne10 = "r0"
PACKAGE_ARCH_pn-ne10 = "${OSS_LAYER_ARCH}"

PR_pn-netbase = "r0"
PACKAGE_ARCH_pn-netbase = "${OSS_LAYER_ARCH}"

PR_pn-nettle = "r0"
PACKAGE_ARCH_pn-nettle = "${OSS_LAYER_ARCH}"

PR_pn-networkmanager = "r1"
PACKAGE_ARCH_pn-networkmanager = "${OSS_LAYER_ARCH}"

PR_pn-nghttp2 = "r0"
PACKAGE_ARCH_pn-nghttp2 = "${OSS_LAYER_ARCH}"

PR_pn-nopoll = "r0"
PACKAGE_ARCH_pn-nopoll = "${OSS_LAYER_ARCH}"

PR_pn-nspr = "r0"
PACKAGE_ARCH_pn-nspr = "${OSS_LAYER_ARCH}"

PR_pn-nss = "r0"
PACKAGE_ARCH_pn-nss = "${OSS_LAYER_ARCH}"

PR_pn-openjpeg = "r0"
PACKAGE_ARCH_pn-openjpeg = "${OSS_LAYER_ARCH}"

PR_pn-openssh = "r0"
PACKAGE_ARCH_pn-openssh = "${OSS_LAYER_ARCH}"

PR_pn-openssl = "r0"
PACKAGE_ARCH_pn-openssl = "${OSS_LAYER_ARCH}"

PR_pn-opkg = "r1"
PACKAGE_ARCH_pn-opkg = "${OSS_LAYER_ARCH}"

PR_pn-opkg-arch-config = "r1"
PACKAGE_ARCH_pn-opkg-arch-config = "${OSS_LAYER_ARCH}"

PR_pn-opkg-utils = "r0"
PACKAGE_ARCH_pn-opkg-utils = "${OSS_LAYER_ARCH}"

PR_pn-orc = "r0"
PACKAGE_ARCH_pn-orc = "${OSS_LAYER_ARCH}"

PR_pn-perl = "r1"
PACKAGE_ARCH_pn-perl = "${OSS_LAYER_ARCH}"

PR_pn-pixman = "r0"
PACKAGE_ARCH_pn-pixman = "${OSS_LAYER_ARCH}"

PR_pn-popt = "r0"
PACKAGE_ARCH_pn-popt = "${OSS_LAYER_ARCH}"

PR_pn-procps = "r1"
PACKAGE_ARCH_pn-procps = "${OSS_LAYER_ARCH}"

PR_pn-protobuf = "r0"
PACKAGE_ARCH_pn-protobuf = "${OSS_LAYER_ARCH}"

PR_pn-protobuf-c = "r0"
PACKAGE_ARCH_pn-protobuf-c = "${OSS_LAYER_ARCH}"

PR_pn-pulseaudio = "r0"
PACKAGE_ARCH_pn-pulseaudio =  "${OSS_LAYER_ARCH}"

PR_pn-python = "r0"
PACKAGE_ARCH_pn-python = "${OSS_LAYER_ARCH}"

PR_pn-python3 = "r0"
PACKAGE_ARCH_pn-python3 = "${OSS_LAYER_ARCH}"

PR_pn-python3-dbus = "r0"
PACKAGE_ARCH_pn-python3-dbus = "${OSS_LAYER_ARCH}"

PR_pn-qrencode = "r0"
PACKAGE_ARCH_pn-qrencode = "${OSS_LAYER_ARCH}"

PR_pn-rapidjson = "r0"
PACKAGE_ARCH_pn-rapidjson = "${OSS_LAYER_ARCH}"

PR_pn-rdkperf = "r0"
PACKAGE_ARCH_pn-rdkperf = "${OSS_LAYER_ARCH}"

PV_pn-rdm = "1.0.1"
PR_pn-rdm = "r1"
PACKAGE_ARCH_pn-rdm = "${OSS_LAYER_ARCH}"

PR_pn-readline = "r9"
PACKAGE_ARCH_pn-readline = "${OSS_LAYER_ARCH}"

PR_pn-redis = "r1"
PACKAGE_ARCH_pn-redis = "${OSS_LAYER_ARCH}"

PR_pn-run-postinsts = "r10"
PACKAGE_ARCH_pn-run-postinsts = "${OSS_LAYER_ARCH}"

PR_pn-safec = "r0"
PACKAGE_ARCH_pn-safec = "${OSS_LAYER_ARCH}"

PR_pn-safec-common-wrapper = "r0"
PACKAGE_ARCH_pn-safec-common-wrapper = "${OSS_LAYER_ARCH}"

PR_pn-sbc = "r0"
PACKAGE_ARCH_pn-sbc = "${OSS_LAYER_ARCH}"

PR_pn-shadow = "r0"
PACKAGE_ARCH_pn-shadow = "${OSS_LAYER_ARCH}"

PR_pn-shadow-securetty = "r3"
PACKAGE_ARCH_pn-shadow-securetty = "${OSS_LAYER_ARCH}"

PR_pn-shadow-sysroot = "r3"
PACKAGE_ARCH_pn-shadow-sysroot = "${OSS_LAYER_ARCH}"

PR_pn-shared-mime-info = "r0"
PACKAGE_ARCH_pn-shared-mime-info = "${OSS_LAYER_ARCH}"

PR_pn-slang = "r0"
PACKAGE_ARCH_pn-slang = "${OSS_LAYER_ARCH}"

PR_pn-smcroute = "r0"
PACKAGE_ARCH_pn-smcroute = "${OSS_LAYER_ARCH}"

PR_pn-speex = "r0"
PACKAGE_ARCH_pn-speex = "${OSS_LAYER_ARCH}"

PR_pn-speexdsp = "r0"
PACKAGE_ARCH_pn-speexdsp = "${OSS_LAYER_ARCH}"

PR_pn-sqlite = "r7"
PACKAGE_ARCH_pn-sqlite = "${OSS_LAYER_ARCH}"

PR_pn-sqlite3 = "r1"
PACKAGE_ARCH_pn-sqlite3 = "${OSS_LAYER_ARCH}"

PR_pn-strace = "r0"
PACKAGE_ARCH_pn-strace = "${OSS_LAYER_ARCH}"

PR_pn-stunnel = "r2"
PACKAGE_ARCH_pn-stunnel = "${OSS_LAYER_ARCH}"

PR_pn-sysfsutils = "r5"
PACKAGE_ARCH_pn-sysfsutils = "${OSS_LAYER_ARCH}"

PR_pn-syslog-ng = "r1"
PACKAGE_ARCH_pn-syslog-ng = "${OSS_LAYER_ARCH}"

PR_pn-systemd = "r9"
PACKAGE_ARCH_pn-systemd = "${OSS_LAYER_ARCH}"

PR_pn-systemd-serialgetty = "r5"
PACKAGE_ARCH_pn-systemd-serialgetty = "${OSS_LAYER_ARCH}"

PR_pn-taglib = "r0"
PACKAGE_ARCH_pn-taglib = "${OSS_LAYER_ARCH}"

PR_pn-tcpdump = "r0"
PACKAGE_ARCH_pn-tcpdump = "${OSS_LAYER_ARCH}"

PR_pn-tcp-wrappers = "r10"
PACKAGE_ARCH_pn-tcp-wrappers = "${OSS_LAYER_ARCH}"

PR_pn-tiff = "r0"
PACKAGE_ARCH_pn-tiff = "${OSS_LAYER_ARCH}"

PR_pn-trace-cmd = "r0"
PACKAGE_ARCH_pn-trace-cmd = "${OSS_LAYER_ARCH}"

PR_pn-tremor = "r0"
PACKAGE_ARCH_pn-tremor = "${OSS_LAYER_ARCH}"

PR_pn-trower-base64 = "r0"
PACKAGE_ARCH_pn-trower-base64 = "${OSS_LAYER_ARCH}"

PR_pn-tzdata = "r1"
PACKAGE_ARCH_pn-tzdata = "${OSS_LAYER_ARCH}"

PR_pn-udev-extraconf = "r1"
PACKAGE_ARCH_pn-udev-extraconf = "${OSS_LAYER_ARCH}"

PR_pn-unzip = "r5"
PACKAGE_ARCH_pn-unzip = "${OSS_LAYER_ARCH}"

PR_pn-update-rc.d = "r0"
PACKAGE_ARCH_pn-update-rc.d = "${OSS_LAYER_ARCH}"

PR_pn-util-linux = "r0"
PACKAGE_ARCH_pn-util-linux = "${OSS_LAYER_ARCH}"

PR_pn-util-macros = "r0"
PACKAGE_ARCH_pn-util-macros = "${OSS_LAYER_ARCH}"

PR_pn-vala = "r0"
PACKAGE_ARCH_pn-vala = "${OSS_LAYER_ARCH}"

PR_pn-vmtouch = "r0"
PACKAGE_ARCH_pn-vmtouch = "${OSS_LAYER_ARCH}"

PR_pn-wayland = "r0"
PACKAGE_ARCH_pn-wayland = "${OSS_LAYER_ARCH}"

PR_pn-wayland-protocols = "r1"
PACKAGE_ARCH_pn-wayland-protocols = "${OSS_LAYER_ARCH}"

PR_pn-websocketpp = "r0"
PACKAGE_ARCH_pn-websocketpp = "${OSS_LAYER_ARCH}"

PR_pn-wireless-regdb = "r0"
PACKAGE_ARCH_pn-wireless-regdb = "${OSS_LAYER_ARCH}"

PR_pn-wireless-tools = "r0"
PACKAGE_ARCH_pn-wireless-tools = "${OSS_LAYER_ARCH}"
PR_pn-woff2 = "r0"
PACKAGE_ARCH_pn-woff2 = "${OSS_LAYER_ARCH}"

PR_pn-wpa-supplicant = "r7"
PACKAGE_ARCH_pn-wpa-supplicant = "${OSS_LAYER_ARCH}"

PR_pn-xkeyboard-config = "r0"
PACKAGE_ARCH_pn-xkeyboard-config = "${OSS_LAYER_ARCH}"

PR_pn-xmlsec1 = "r0"
PACKAGE_ARCH_pn-xmlsec1 = "${OSS_LAYER_ARCH}"

PR_pn-xz = "r0"
PACKAGE_ARCH_pn-xz = "${OSS_LAYER_ARCH}"

PR_pn-yajl = "r0"
PACKAGE_ARCH_pn-yajl = "${OSS_LAYER_ARCH}"

PR_pn-zlib = "r0"
PACKAGE_ARCH_pn-zlib = "${OSS_LAYER_ARCH}"

PR_pn-zstd = "r0"
PACKAGE_ARCH_pn-zstd = "${OSS_LAYER_ARCH}"
