include ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-profile', 'profiles/rdk-${BPN}-profile.inc', 'profiles/generic-profile.inc', d)}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:"

PACKAGECONFIG:remove = "vconsole ldconfig"
PACKAGECONFIG:remove = " resolved nss-resolve "

PACKAGECONFIG:remove:libc-uclibc = "sysusers machined"

DEPENDS += " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " apparmor", "" ,d)}"
PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'apparmor', 'apparmor', '', d)}"
PACKAGECONFIG[apparmor] = "--enable-apparmor, --disable-apparmor"

#Remove volatile bind dependency as it is not an oss delivered component
RDEPENDS:${PN}:remove = "volatile-binds"


_OECONF += "--disable-ldconfig"
EXTRA_OECONF:append:libc-uclibc = " --disable-sysusers --disable-machined "

CFLAGS:append:arm = " -fno-lto"

SRC_URI += " \
           file://50-portreserv.conf \
           "
SRC_URI:append = " \
            file://build-sys-add-check-for-gperf-lookup-function-signat.patch \
            file://rfkill_rdk.conf \
           "
BACKPORTS ?= " "

RRECOMMENDS:${PN} += " \
        util-linux-swaponoff util-linux-losetup \
        util-linux-libmount util-linux-umount \
"
PACKAGES =+ "${PN}-rfkill-conf"

FILES:${PN}:append = " ${datadir}/bash-completion"

FILES:${PN}-rfkill-conf = "${systemd_unitdir}/system/systemd-rfkill.service.d/rfkill_rdk.conf"

do_install:append() {
	install -d ${D}${localstatedir}/lib/systemd/coredump
        ln -s /dev/null ${D}${sysconfdir}/udev/rules.d/80-net-setup-link.rules

        install -D -m 0644 ${WORKDIR}/rfkill_rdk.conf ${D}${systemd_unitdir}/system/systemd-rfkill.service.d/rfkill_rdk.conf

        sed -i -e 's/^#DumpCore=.*$/DumpCore=yes/g' ${D}${sysconfdir}/systemd/system.conf
        sed -i -e 's/^#DumpCore=.*$/LogColor=no/g' ${D}${sysconfdir}/systemd/system.conf
        sed -i -e 's/^#DefaultLimitCORE=.*$/DefaultLimitCORE=infinity/g' ${D}${sysconfdir}/systemd/system.conf

        sed -i -e 's/^#DumpCore=.*$/LogColor=no/g' ${D}${sysconfdir}/systemd/user.conf
        sed -i -e 's/^#DefaultLimitCORE=.*$/DefaultLimitCORE=infinity/g' ${D}${sysconfdir}/systemd/user.conf
        #Journal conf overide
        sed -i -e 's/.*ForwardToSyslog=.*/ForwardToSyslog=yes/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*Storage=.*/Storage=volatile/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxUse=.*/SystemMaxUse=16M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxUse=.*/RuntimeMaxUse=16M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFileSize=.*/RuntimeMaxFileSize=4M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxFileSize=.*/SystemMaxFileSize=4M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RateLimitInterval=.*/RateLimitInterval=0/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RateLimitIntervalSec=.*/RateLimitIntervalSec=0/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RateLimitBurst=.*/RateLimitBurst=0/g' ${D}${sysconfdir}/systemd/journald.conf

        sed -i -e 's/10d/-/g' ${D}${exec_prefix}/lib/tmpfiles.d/tmp.conf
        sed -i -e 's/30d/-/g' ${D}${exec_prefix}/lib/tmpfiles.d/tmp.conf
        rm -rf ${D}${bindir}/busctl
        rm -rf ${D}${datadir}/bash-completion/completions/busctl
        rm -rf ${D}${libdir}/libnss_mymachines.so.2
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-bus-proxyd
if ${@bb.utils.contains('EXTRA_OECONF', '--enable-hwselftest', 'false', 'true', d)}; then
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-socket-proxyd
fi
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-ac-power
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-sleep
	rm -rf ${D}${rootlibexecdir}/systemd/systemd-reply-password
	rm -rf ${D}${rootlibexecdir}/systemd/systemd-activate
	sed -i -e 's/systemd-fsck-root.service//g' ${D}${systemd_unitdir}/system/systemd-remount-fs.service
if ! ${@bb.utils.contains('PACKAGECONFIG', 'resolved', 'true', 'false', d)}; then
        sed -i -e '/^L! \/etc\/resolv\.conf*/d' ${D}${exec_prefix}/lib/tmpfiles.d/etc.conf
fi
}

do_install:append:client() {
        install -d ${D}/media/apps
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-binfmt
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-binfmt.service
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-update-done
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-update-done.service
        rm -rf ${D}${rootlibexecdir}/systemd/system/sysinit.target.wants/systemd-update-done.service
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-journal-catalog-update.service
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-sysusers.service || true
}

do_install:append:hybrid() {
        install -d ${D}/media/apps
        install -d ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/50-portreserv.conf ${D}${sysconfdir}/sysctl.d
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-binfmt
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-binfmt.service
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-update-done
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-update-done.service
        rm -rf ${D}${rootlibexecdir}/systemd/system/sysinit.target.wants/systemd-update-done.service
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-journal-catalog-update.service
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-sysusers.service || true
}

SYSTEMD_SERVICE:systemd-binfmt:remove = " systemd-binfmt.service"

FILES:${PN}:remove = "${bindir}/busctl ${datadir}/bash-completion/completions/busctl ${libdir}/libnss_mymachines.so.2 ${rootlibexecdir}/systemd/systemd-bus-proxyd ${rootlibexecdir}/systemd/systemd-ac-power ${rootlibexecdir}/systemd/systemd-sleep ${rootlibexecdir}/systemd/systemd-reply-password ${rootlibexecdir}/systemd/systemd-activate"

FILES:${PN}:append:client = " /media/apps"
FILES:${PN}:append:hybrid = " /media/apps"
FILES:${PN}:append:hybrid += "${sysconfdir}/sysctl.d/50-portreserv.conf"
FILES:${PN} += "/media"

SYSTEMD_SERVICE:systemd-binfmt:remove:hybrid = " systemd-binfmt.service"
SYSTEMD_SERVICE:systemd-binfmt:remove:client = " systemd-binfmt.service"

SRC_URI += " \
    file://journalctl-230.patch \
    file://systemd230-journalctl-remove-noentries-log.patch \
    file://10-ubi-device-systemd.rules \
    file://CVE-2017-9217_230.5_fix.patch \
    file://CVE-2018-1049_230.5_fix.patch \
    file://CVE-2018-15688_230.5_fix.patch \
    file://CVE-2018-16866_230.5_fix.patch \
    file://CVE-2019-3842_230.5_fix.patch \
    file://CVE-2019-20386_230.5_fix.patch \
    file://CVE-2017-15908_230.5_fix.patch \
    file://CVE-2017-18078_230.5_fix.patch \
    file://CVE-2017-9445_230.5_fix.patch \
    file://CVE-2018-16865_230.5_fix.patch \
    file://CVE-2022-3821_230.5_fix.patch \
"

## The below patches are needed to build systemd V230 with glibc V2.31 on dunfell(Yocto 3.1)
# journald-minimal-client-metadata-caching patch contains changes the remaining 3 patches as well
SRC_URI:append = " \
            ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-journal-cache', 'file://journald-minimal-client-metadata-caching.patch', '\
            file://0001-memfd-patch-for-latest-version-of-glibc.patch \
            file://0002-Remove-include-of-xlocale-header.patch \
            file://0003-Remove-MS-constants-from-missing-header-file.patch', d)} \
            file://0001-nss-util-silence-warning-about-deprecated-RES_USE_IN.patch \
            file://99-default.preset \
            "

EXTRA_OECONF += " --enable-polkit=no"
PACKAGECONFIG:remove = "pam"
FILES:${PN} += "${sysconfdir}/udev/rules.d/10-ubi-device-systemd.rules"

do_install:append() {
    rm -rf ${D}${sysconfdir}/resolv.conf
    sed -i '/After=swap.target/d' ${D}${systemd_unitdir}/system/tmp.mount

    rm -rf ${D}${base_libdir}/systemd/system/ldconfig.service
    rm -rf ${D}${base_libdir}/systemd/system/sysinit.target.wants/ldconfig.service

    # disable LLMNR queries
    if [ -f  ${D}${sysconfdir}/systemd/resolved.conf ]; then
        sed -i '/LLMNR/c\LLMNR=no' ${D}${sysconfdir}/systemd/resolved.conf
    fi
}

do_install:append:client() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/10-ubi-device-systemd.rules ${D}${sysconfdir}/udev/rules.d/    
    rm -rf ${D}${base_libdir}/systemd/systemd-update-done
    rm -rf ${D}${base_libdir}/systemd/system/systemd-update-done.service
    rm -rf ${D}${base_libdir}/systemd/system/sysinit.target.wants/systemd-update-done.service
    sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-journal-catalog-update.service
    sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-hwdb-update.service || true
}

do_install:append:hybrid() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/10-ubi-device-systemd.rules ${D}${sysconfdir}/udev/rules.d/    
    sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-hwdb-update.service || true
}

do_install:append:broadband() {
    rm -rf ${D}${libdir}/tmpfiles.d/home.conf
}

do_install:append() {
    install -Dm 0644 ${WORKDIR}/99-default.preset ${D}${systemd_unitdir}/system-preset/99-default.preset
}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
           file://systemd230-journald-syslog-logmissing.patch \
           file://systemd230-remove-srv-dir-check.patch \
           "

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:${THISDIR}/${BPN}:"

SRC_URI += "\
            file://systemd230-ntp-event-trigger.patch \
            file://systemd230-tmpfiles.patch \
            file://systemd230-forec-reboot-on-freeze.patch \
            file://0001-Added-decrement-of-notify-watchers-when-we-dont-need.patch \
            file://0001-Added-code-to-cleanup-all-the-xisting-watches-on-pat.patch \
            file://add_info_ntp_analytics.patch \
            file://ntp_client_info.patch \
           "
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systimemgr', ' file://systemtimemgr_ntp.patch', '', d)} "
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systimemgr', ' file://0001-In-our-echo-system-we-are-managing-last-known-good-t.patch', '', d)} "

#PACKAGECONFIG:append = " timesyncd"
#PACKAGECONFIG[timesyncd] = "--enable-timesyncd,--disable-timesyncd"


do_install:append() {
        install -d ${D}/media/tsb
        #Enable comcast ntp server in timesyncd.conf
        if [ -n "${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'timesyncd', '', d)}" ]; then
           sed -i -e '/ProtectSystem=full/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/PrivateTmp=yes/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^#ShutdownWatchdogSec=.*$/ShutdownWatchdogSec=1min/g' ${D}${sysconfdir}/systemd/system.conf
           sed -i -e 's/^#NTP=.*/NTP=time.google.com/g' ${D}${sysconfdir}/systemd/timesyncd.conf
       fi

}

do_install:append:hybrid() {
        #Enable comcast ntp server in timesyncd.conf
        if [ -n "${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'timesyncd', '', d)}" ]; then
           sed -i -e 's/ExecStart=\/lib\/systemd\/systemd-timesyncd/ExecStart=\/bin\/sh -c \/bin\/echo systemd-timesyncd not needed in gateways/' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/Restart=always/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/WatchdogSec=1min/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/PrivateDevices=yes/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/ProtectHome=yes/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/CapabilityBoundingSet=CAP_SYS_TIME CAP_SETUID CAP_SETGID CAP_SETPCAP CAP_CHOWN CAP_DAC_OVERRIDE CAP_FOWNER/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/Type=notify/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/RestartSec=0/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service

        fi
        #RDK-20332 : Further Analysis on Systemd Optimisation

        rm -rf ${D}${base_libdir}/systemd/systemd-reply-password
        rm -rf ${D}${base_libdir}/systemd/systemd-activate
}

FILES:${PN}:append = " /media/tsb"


FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
                 file://0001-no-exec-mount-opt-shm.patch \
                 "

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', 'false', 'true', d)}; then
    sed -i -e 's/Options=/Options=nosuid,nodev,noexec,/' ${D}${systemd_unitdir}/system/tmp.mount
    fi

    if ${@bb.utils.contains('DISTRO_FEATURES', 'syslog-ng', 'false', 'true', d)}; then
        #Journal conf overide
        sed -i -e 's/.*ForwardToSyslog=.*/#ForwardToSyslog=no/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxUse=.*/SystemMaxUse=8M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxUse=.*/RuntimeMaxUse=8M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFileSize=.*/RuntimeMaxFileSize=4M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxFileSize=.*/SystemMaxFileSize=4M/g' ${D}${sysconfdir}/systemd/journald.conf
    else
        #Update Journal configuration if syslog-ng is enabled
        sed -i -e 's/.*ForwardToSyslog=.*/#ForwardToSyslog=no/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFileSize=.*/RuntimeMaxFileSize=3M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxUse=.*/SystemMaxUse=3M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxFileSize=.*/SystemMaxFileSize=3M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFiles=.*/RuntimeMaxFiles=2/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxFiles=.*/SystemMaxFiles=2/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxUse=.*/RuntimeMaxUse=3M/g' ${D}${sysconfdir}/systemd/journald.conf
    fi
}

do_install:append:client() {
        install -d ${D}/media/tsb
}

do_install:append:hybrid() {
        install -d ${D}/media/tsb
}

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'syslog-ng', 'false', 'true', d)}; then
        #Journal conf overide
        sed -i -e 's/.*RuntimeMaxFiles=.*/RuntimeMaxFiles=2/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*SystemMaxFiles=.*/SystemMaxFiles=2/g' ${D}${sysconfdir}/systemd/journald.conf
    fi
}


BBCLASSEXTEND:append = " native nativesdk"


# systemd_230.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " file://0001-Reduced-retry-interval-to-5-secs.patch \
             file://0002-udev-stop-freeing-value-afteru-using-it-for-setting-sysattr.patch \
             file://0003-udev-use-interface-before-the-string-is-freed.patch \
           "

