inherit comcast-rdm-package-support

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://package.json \
            file://strace-post-install.sh"

RDM_APPS = "${@bb.utils.contains('DISTRO_FEATURES', 'rdm', '${BPN}', '', d)}"

RDM_PACKAGES_${BPN} = "${PN}-dl"
RDM_ON_DEMAND_${BPN} = "yes"
RDM_METHOD_CONTROLLER_${BPN} = "RFC"

ENABLE_RDM_VERSIONING_${BPN} = "${@bb.utils.contains('DISTRO_FEATURES', 'rdm rdm-versioning', 'true', 'false', d)}"

PACKAGE_TYPE_${BPN} = "app"
PKG_FIRMWARE_DECOUPLED_${BPN} = "true"

PKG_BUNDLE_NAME_${BPN} = "${MACHINE_IMAGE_NAME}-strace"
PKG_BUNDLE_VERSION_${BPN} = "1.0"

PACKAGE_BEFORE_PN += "${PN}-dl"
ALLOW_EMPTY:${PN}-dl = "1"

RDEPENDS:${PN} += " ${PN}-dl"

do_install:append() {
    install -d ${D}${sysconfdir}/rdm/post-services
    install -m 0755 ${WORKDIR}/strace-post-install.sh \
        ${D}${sysconfdir}/rdm/post-services/strace-post-install.sh

    if [ "${ENABLE_RDM_VERSIONING_${BPN}}" = "true" ]; then
        install -d ${D}${sysconfdir}/apps
        install -m 0644 ${WORKDIR}/package.json \
            ${D}${sysconfdir}/apps/${PKG_BUNDLE_NAME_${BPN}}_package.json
    fi
}

FILES:${PN}-dl += "${bindir}/strace \
                   ${sysconfdir}/rdm/post-services/strace-post-install.sh \
                   ${sysconfdir}/apps/${PKG_BUNDLE_NAME_${BPN}}_package.json"

pkg_postinst:${PN}-dl () {
    if [ -n "$D" -a -d "$D" ]; then
        echo "Removing strace binary from rootfs"
        rm -f $D${bindir}/strace
    fi
}
