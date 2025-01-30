SRC_URI += "file://download_apps.sh"
SRC_URI += "file://apps_rdm.sh"
SRC_URI += "file://apps-rdm.service"
SRC_URI += "file://apps_rdm.path"
SRC_URI += "file://apps_prerdm.sh"
SRC_URI += "file://apps-prerdm.service"
SRC_URI += "file://jsonquery.c"
SRC_URI += "file://rdm_apps_rfc_check.sh"

CFLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'rdm-catalogue-mgmt', '', '-DRDM_BACKWARD_COMPATIBLE', d)}"
CFLAGS += "-I${PKG_CONFIG_SYSROOT_DIR}/usr/include/cjson -lcjson"
DEPENDS += "cjson"

DEPENDS:remove:class-nativesdk="cjson"
do_compile:append:class-target () {
        ${CC} -Wall -Wextra ${WORKDIR}/jsonquery.c $CFLAGS -o ${WORKDIR}/jsonquery
}

do_install:append:class-target () {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/jsonquery ${D}${bindir}/
}
#Native SDK additions
do_install:class-nativesdk () {
        mkdir -p ${D}${SDKPATHNATIVE}${sbindir_nativesdk}
        install -m 0755 ${S}/scripts/ThirdPartyPackageSigning.sh ${D}${SDKPATHNATIVE}${sbindir_nativesdk}/ThirdPartyPackageSigning.sh
}

FILES:${PN}:class-nativesdk = "${SDKPATHNATIVE}${sbindir_nativesdk}/ThirdPartyPackageSigning.sh"
BBCLASSEXTEND = "nativesdk"
#Native SDK additions end

INSANE_SKIP:${PN} = "ldflags"
