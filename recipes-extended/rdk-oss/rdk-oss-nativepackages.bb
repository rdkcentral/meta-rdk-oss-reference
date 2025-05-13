SUMMARY = "The RDK OSS native packages assist in building the necessary native packages for RDK builds. This target can be utilized to create a locked sstate with native tools and toolchain."

LICENSE = "MIT"
PV = "1.0.0"
PR = "r0"

INHIBIT_DEFAULT_DEPS = "1"
EXCLUDE_FROM_WORLD = "1"

# native packages 
DEPENDS = "\
    abseil-cpp-native \
    acl-native \
    attr-native \
    autoconf-archive-native \
    autoconf-native \
    automake-native \
    bc-native \
    bison-native \
    boost-build-native \
    breakpad-native \
    bzip2-native \
    c-ares-native \
    ca-certificates-native \
    ccache-native \
    chrpath-native \
    cmake-native \
    coreutils-native \
    cracklib-native \
    cross-localedef-native \
    curl-native \
    db-native \
    dbus-glib-native \
    dbus-native \
    debianutils-native \
    docbook-xml-dtd4-native \
    docbook-xsl-stylesheets-native \
    doxygen-native \
    dwarfsrcfiles-native \
    dwz-native \
    e2fsprogs-native \
    elfutils-native \
    expat-native \
    file-native \
    flex-native \
    gdbm-native \
    gdk-pixbuf-native \
    gettext-minimal-native \
    gettext-native \
    glib-2.0-native \
    gmp-native \
    gnu-config-native \
    gobject-introspection-native \
    gperf-native \
    groff-native \
    grpc-native \
    gtk-doc-native \
    icu-native \
    intltool-native \
    itstool-native \
    jsoncpp-native \
    kern-tools-native \
    kmod-native \
    ldconfig-native \
    libarchive-native \
    libcap-native \
    libcap-ng-native \
    libffi-native \
    libgcrypt-native \
    libgpg-error-native \
    libical-native \
    libjpeg-native \
    libmpc-native \
    libnsl2-native \
    libpcre-native \
    libpcre2-native \
    libpng-native \
    libsolv-native \
    libssh2-native \
    libtirpc-native \
    libtool-native \
    libxml-parser-perl-native \
    libxml2-native \
    libxslt-native \
    libyaml-native \
    lua-native \
    lz4-native \
    lzo-native \
    lzop-native \
    m4-native \
    makedevs-native \
    make-native \
    meson-native \
    mpfr-native \
    nasm-native \
    ncurses-native \
    ninja-native \
    nodejs-native \
    nspr-native \
    nss-native \
    openssl-native \
    opkg-native \
    opkg-utils-native \
    orc-native \
    patchelf-native \
    patch-native \
    pbzip2-native \
    perl-native \
    perl-native \
    pigz-native \
    perlcross-native \
    pkgconfig-native \
    popt-native \
    protobuf-c-native \
    protobuf-native \
    pseudo-native \
    python-native \
    python3-asn1crypto-native \
    python3-certifi-native \
    python3-cffi-native \
    python3-cryptography-native \
    python3-flit-core-native \
    python3-idna-native \
    python3-installer-native \
    python3-jsonref-native \
    python3-lxml-native \
    python3-native \
    python3-packaging-native \
    python3-pycparser-native \
    python3-pyopenssl-native \
    python3-pyparsing-native \
    python3-semantic-version-native \
    python3-setuptools-native \
    python3-setuptools-rust-native \
    python3-setuptools-scm-native \
    python3-six-native \
    python3-tomli-native \
    python3-toml-native \
    python3-typing-extensions-native \
    python3-urllib3-native \
    python3-wheel-native \
    python-lxml-native \
    python-native \
    python-setuptools-native \
    qemu-native \
    quilt-native \
    re2-native \
    re2c-native \
    readline-native \
    rpm-native \
    rsync-native \
    ruby-native \
    shadow-native \
    shared-mime-info-native \
    sqlite3-native \
    squashfs-tools-native \
    systemd-systemctl-native \
    texinfo-dummy-native \
    tzcode-native \
    u-boot-tools-native \
    unifdef-native \
    unzip-native \
    update-rc.d-native \
    util-linux-libuuid-native \
    util-linux-native \
    vala-native \
    wayland-native \
    xmlto-native \
    xz-native \
    zlib-native \
    zstd-native \
"

# toolchain
DEPENDS += "gcc-cross-${TARGET_ARCH} binutils-cross-${TARGET_ARCH}"

# rust compiler
DEPENDS += "rust-cross-${TUNE_PKGARCH}-${TCLIBC} rust-native rust-llvm-native cargo-native"

do_fetch[noexec] = "1"
do_unpack[noexec] = "1"
do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"

