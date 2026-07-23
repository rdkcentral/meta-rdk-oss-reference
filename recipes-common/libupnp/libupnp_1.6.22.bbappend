FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://CVE-2020-13848_fix.patch "

# libupnp 1.6.22 sample TV device fails to compile against newer libc/compilers.
# Samples are never installed to the target rootfs.
EXTRA_OECONF += "--disable-samples"
