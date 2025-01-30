SUMMARY = "A fast and lightweight fully featured OCI runtime and C library for running containers"

DESCRIPTION = "A fast and low-memory footprint OCI Container Runtime fully written in C.\
crun conforms to the OCI Container Runtime specifications"

HOMEPAGE = "https://github.com/containers/crun"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "gitsm://github.com/containers/crun;branch=main"

SRCREV = "0356bf4aff9a133d655dc13b1d9ac9424706cac4"

DEPENDS += "yajl libseccomp libtool libcap"
DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'RDKTV_CHECKPOINT_RESTORE', ' criu', '', d)}"

S = "${WORKDIR}/git"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit autotools-brokensep pkgconfig

do_configure:prepend () {
    cd ${S}
    ./autogen.sh
}

# Don't need systemd integration, so disable it to remove dependency on libsystemd
EXTRA_OECONF = "--disable-systemd"
