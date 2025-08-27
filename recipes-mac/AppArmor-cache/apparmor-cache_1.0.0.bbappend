FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PV:pn-apparmor-cache = "1.0.0"
PR:pn-apparmor-cache = "r0"
PACKAGE_ARCH:pn-apparmor-cache = "${MIDDLEWARE_ARCH}"

SRC_URI:append = " file://sp_cfg/"

do_install:append:class-target () {
    install -d ${STAGING_DIR_NATIVE}/usr/share/service_profiles/
    install -d ${D}/etc/apparmor/aa_profiles/

    # We rely on the image recipe to compile profiles located in <rootfs>/etc/apparmor/aa_profiles. 
    python3 ${WORKDIR}/serviceprofile_parse/parse.py ${WORKDIR}/sp_cfg/rdke/ ${STAGING_DIR_NATIVE}/usr/share/service_profiles/
    cp -fr ${STAGING_DIR_NATIVE}/usr/share/service_profiles/* ${D}/etc/apparmor/aa_profiles/
}
