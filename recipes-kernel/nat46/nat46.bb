LICENSE="GPL-2.0-only"
LIC_FILES_CHKSUM="file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit module

SRC_URI += "\
	git://github.com/ayourtch/nat46.git;protocol=https;branch=master  \
           "
SRCREV = "95ca1c3b99376da2d0306919f2df4a8d3c9bb78b"
SRCREV:wrynose = "9e08da84b6e77c8076d0e4f204af6c29c2c64f6e"


S = "${UNPACKDIR}"

KERNEL_SRC = "${UNPACKDIR}/../../../../work-shared/${MACHINE}/kernel-source"
KERNEL_SRC:wrynose = "${STAGING_KERNEL_DIR}"

NAT46_MODDIR = "${UNPACKDIR}/git/nat46/modules"
NAT46_MODDIR:wrynose = "${UNPACKDIR}/${BP}/nat46/modules"

NAT46_MODDEST = "/lib/modules/${KERNEL_VERSION}/extra"
NAT46_MODDEST:wrynose = "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra"

NAT46_MAKE_ARGS = ""
NAT46_MAKE_ARGS:wrynose = "CC='${KERNEL_CC}' LD='${KERNEL_LD}'"
do_compile() {
		make -C "${KERNEL_SRC}" M="${NAT46_MODDIR}" ${NAT46_MAKE_ARGS} EXTRA_CFLAGS="-DNAT46_VERSION=\\\"$(SRCREV)\\\""
}

do_install () {
		install -d ${D}${NAT46_MODDEST}
		install -d ${D}/usr/include/nat46
		install -d ${D}/etc/modprobe.d
		install -d ${D}/etc/modules-load.d
		install -m 644 ${NAT46_MODDIR}/nat46.ko ${D}${NAT46_MODDEST}
		install -m 644 ${NAT46_MODDIR}/Module.symvers ${D}/usr/include/nat46
}


# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

FILES:${PN}:append:wrynose = " ${sysconfdir}/modprobe.d ${sysconfdir}/modules-load.d"

RPROVIDES_${PN} += "kernel-module-hello"
