do_install:append() {
if [ -e ${UNPACKDIR}/pam.d ]; then
     install -d ${D}${sysconfdir}/pam.d/
     install -m 0644 ${UNPACKDIR}/pam.d/* ${D}${sysconfdir}/pam.d/
     #Denies root to su without passwods
     sed -i 's/^auth/#auth/g' ${D}${sysconfdir}/pam.d/su
fi
}
