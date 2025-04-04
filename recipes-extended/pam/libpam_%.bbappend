#To avoid copying coreutils binaries into /bin folder, which is overriding the busybox binaries.
RDEPENDS:${PN}-xtests:remove = "coreutils"
RDEPENDS:${PN}-xtests:append = " bash"


PACKAGE_BEFORE_PN += "${PN}-extras"
FILES:${PN}-extras =  "\
                        ${base_libdir}/libpamc.so* \
                        ${base_libdir}/security/pam_rootok.so \
                        ${base_libdir}/security/pam_shells.so \
                        ${sbindir}/faillock \
                        ${sbindir}/mkhomedir_helper \
                        ${sbindir}/pam_timestamp_check \
                        ${sbindir}/pwhistory_helper \
                        ${sbindir}/unix_chkpwd \
                        ${sbindir}/unix_update \
"
