LICENSE="GPL-2.0-only"
LIC_FILES_CHKSUM="file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit module

SRC_URI += "\
	git://github.com/ayourtch/nat46.git;protocol=https;branch=master  \
           "
SRCREV = "95ca1c3b99376da2d0306919f2df4a8d3c9bb78b"


S = "${UNPACKDIR}"

KERNEL_SRC = "${UNPACKDIR}/../../../../work-shared/${MACHINE}/kernel-source"
do_compile() {
		make -C "${KERNEL_SRC}" M="${UNPACKDIR}/git/nat46/modules" EXTRA_CFLAGS="-DNAT46_VERSION=\\\"$(SRCREV)\\\""
}

do_install () {
		install -d ${D}/lib/modules/${KERNEL_VERSION}/extra
		install -d ${D}/usr/include/nat46
		install -d ${D}/etc/modprobe.d
		install -d ${D}/etc/modules-load.d
		install -m 644 ${S}/git/nat46/modules/nat46.ko ${D}/lib/modules/${KERNEL_VERSION}/extra
		install -m 644 ${S}/git/nat46/modules/Module.symvers ${D}/usr/include/nat46
}


# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES_${PN} += "kernel-module-hello"
