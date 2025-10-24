SUMMARY = "OSS layer packagegroup"

LICENSE = "MIT"

PACKAGE_ARCH = "${OSS_LAYER_ARCH}"

inherit packagegroup


PV = "4.9.0"
PR = "r0"

# poky components
RDEPENDS:${PN} = "\
     abseil-cpp \
     acl \
     alsa-lib \
     alsa-plugins \
     alsa-state \
     alsa-topology-conf \
     alsa-ucm-conf \
     alsa-utils \
     alsa-utils-scripts \
     atk \
     attr \
     autoconf-archive \
     avahi \
     base-files \
     base-passwd \
     bash-completion \
     bind \
     boost \
     busybox \
     bzip2 \
     ca-certificates \
     cracklib \
     curl \
     db \
     dbus \
     dbus-glib \
     depmodwrapper-cross \
     dropbear \
     e2fsprogs \
     elfutils \
     expat \
     file \
     flac \
     flex \
     fontconfig \
     freetype \
     fribidi \
     gdk-pixbuf \
     glib-2.0 \
     gmp \
     gobject-introspection \
     harfbuzz \
     heaptrack \
     icu \
     init-system-helpers \
     initscripts \
     iptables \
     iso-codes \
     json-c \
     jquery \
     kbd \
     kmod \
     libaio \
     libatomic-ops \
     libcap \
     libcap-ng \
     libcgroup \
     libcheck \
     libcroco \
     libdaemon \
     libepoxy \
     liberation-fonts \
     libevdev \
     libevent \
     libexif \
     libffi \
     libgcrypt \
     libgpg-error \
     libgudev \
     libical \
     libidn2 \
     libinput \
     libjpeg \
     libmd \
     libnl \
     libnsl2 \
     libnss-mdns \
     libogg \
     libpam \
     libpcap \
     libpciaccess \
     libpcre2 \
     libpng \
     libpsl \
     libpthread-stubs \
     libsamplerate0 \
     libsndfile1 \
     libsolv \
     libsoup \
     libsoup-2.4 \
     libtheora \
     libtirpc \
     libtool \
     libtool-cross \
     libunistring \
     libunwind \
     liburcu \
     libusb1 \
     libvorbis \
     libwpe \
     libxcrypt \
     libxml2 \
     libxslt \
     lsof \
     lttng-ust \
     lz4 \
     lzo \
     mpg123 \
     mtdev \
     mtd-utils \
     ncurses \
     netbase \
     openssh \
     opkg \
     opkg-arch-config \
     opkg-utils \
     packagegroup-base \
     packagegroup-core-boot \
     perl \
     pixman \
     popt \
     pulseaudio \
     python3 \
     python3-dbus \
     python3-pycairo \
     python3-pygobject \
     qemuwrapper-cross \
     run-postinsts \
     re2 \
     sbc \
     shadow \
     shadow-securetty \
     shadow-sysroot \
     speex \
     speexdsp \
     sqlite3 \
     strace \
     sysfsutils \
     systemd-serialgetty \
     taglib \
     tcp-wrappers \
     tcpdump \
     tiff \
     tzdata \
     udev-extraconf \
     unzip \
     update-rc.d \
     util-linux \
     util-linux-libuuid \
     util-macros \
     vala \
     wayland \
     wayland-protocols \
     wireless-regdb \
     xkeyboard-config \
     xz \
"

# meta-openembedded components
RDEPENDS:${PN} += "\
     breakpad \
     c-ares \
     cjson \
     cunit \
     dibbler-client \
     directfb \
     ebtables \
     ethtool \
     evtest \
     fmt \
     gflags \
     googletest \
     grpc \
     gssdp \
     hiredis \
     iperf3 \
     jsonrpc \
     keyutils \
     lcms \
     libev \
     libmicrohttpd \
     libmng \
     libmnl \
     liboauth \
     libol \
     libomxil \
     libopus \
     libsdl \
     libsdl-ttf \
     libsdl-image \
     libtinyxml \
     libtinyxml2 \
     libuv \
     libvpx \
     libwebsockets \
     libzip \
     lua \
     lvm2 \
     mdns \
     mosquitto \
     msgpack-c \
     ndisc6-rdnssd \
     ne10 \
     nspr \
     nss \
     openjpeg \
     paho-mqtt-c \
     protobuf \
     protobuf-c \
     qrencode \
     rapidjson \
     redis \
     safec \
     sqlite \
     stunnel \
     syslog-ng \
     tremor \
     trace-cmd \
     websocketpp \
     xmlsec1 \
     yajl \
     zstd \
"

# meta-rust components
RDEPENDS:${PN} += "\
     libstd-rs \
"

# meta-python2 components
RDEPENDS:${PN} += "\
     python \
"

# meta-rdk-oss-reference components
RDEPENDS:${PN} += "\
     apparmor \
     bash \
     bluez5 \
     breakpad-wrapper \
     cairo \
     civetweb \
     coreutils \
     crun \
     ctemplate \
     dnsmasq \
     dosfstools \
     essos \
     fcgi \
     findutils \
     gawk \
     gdbm \
     gettext \
     glib-networking \
     gmp \
     gnutls \
     graphite2 \
     gstreamer1.0 \
     gstreamer1.0-libav \
     gstreamer1.0-meta-base \
     gstreamer1.0-omx \
     gstreamer1.0-plugins-bad \
     gstreamer1.0-plugins-base \
     gstreamer1.0-plugins-good \
     gstreamer1.0-rtsp-server \
     gupnp \
     iw \
     jansson \
     jsoncpp \
     libarchive \
     libbsd \
     libdash \
     libdrm \
     libdwarf \
     libmanette \
     libndp \
     libnewt \
     libpcre \
     libseccomp \
     librsvg \
     libtasn1 \
     libwebp \
     libxkbcommon \
     lighttpd \
     linenoise \
     linux-libc-headers \
     log4c \
     logrotate \
     m4 \
     make-mod-scripts \
     mbedtls \
     minizip \
     mongoose \
     nanomsg \
     nettle \
     networkmanager \
     nghttp2 \
     nopoll \
     openssl \
     openssl-1.1.1l \
     orc \
     pango \
     procps \
     rdkperf \
     readline \
     safec-common-wrapper \
     sed \
     shared-mime-info \
     slang \
     smcroute \
     systemd \
     trower-base64 \
     vmtouch \
     volatile-binds \
     wayland-default-egl \
     westeros \
     westeros-simplebuffer \
     westeros-simpleshell \
     wireless-tools \
     wpa-supplicant \
     zlib \
"

# glibc and gcc related 
RDEPENDS:${PN} += "\
     gcc-sanitizers \
     glibc \
     glibc-mtrace \
     libgcc \
     libgcc-initial \
     libstdc++ \
     localedef \
"

# Following packages are currently excluded
RDEPENDS:${PN}:remove += "\
     alsa-plugins \
     bluez5 \
     cairo \
     dropbear \
     essos \
     gstreamer1.0 \
     gstreamer1.0-libav \
     gstreamer1.0-meta-base \
     gstreamer1.0-omx \
     gstreamer1.0-plugins-bad \
     gstreamer1.0-plugins-base \
     gstreamer1.0-plugins-good \
     gstreamer1.0-rtsp-server \
     libdrm \
     libepoxy \
     librsvg \
     libwpe \
     make-mod-scripts \
     mpg123 \
     packagegroup-base \
     packagegroup-core-boot \
     pango \
     pulseaudio \
     python3-pycairo \
     python3-pygobject \
     westeros \
     westeros-simplebuffer \
     westeros-simpleshell \
     directfb \
"

# Browser related
RDEPENDS:${PN} += "\
     woff2 \
     brotli \
"
