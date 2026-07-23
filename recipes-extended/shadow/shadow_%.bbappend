do_install:append() {
if [ -e ${WORKDIR}/pam.d ]; then
     install -d ${D}${sysconfdir}/pam.d/
     install -m 0644 ${WORKDIR}/pam.d/* ${D}${sysconfdir}/pam.d/
     #Denies root to su without passwods
     sed -i 's/^auth/#auth/g' ${D}${sysconfdir}/pam.d/su
fi
}

# OE6 wrynose: [build-deps] base-passwd/securetty/sulogin are runtime-only; not build deps
INSANE_SKIP:${PN}:append:wrynose = " build-deps"
