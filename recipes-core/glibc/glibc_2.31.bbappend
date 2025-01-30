FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_broadband = " file://0024-glibc-2.31-ignore-truncated-dns-response.patch"

SRC_URI += "\
        file://0001-glibc-2.31-mips-clone-stack-alignment.patch \
        file://0001-Fix-dlopen-filter-2.31.patch \
        "
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'enable_heaptrack','file://size.patch','',d)} "
