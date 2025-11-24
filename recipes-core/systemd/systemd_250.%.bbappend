#meta-rdk-broadband/recipes-core/systemd/systemd_%.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Remove unwanted systemd services
PACKAGECONFIG:remove:broadband = " timesyncd "

SRC_URI:append:broadband = " \
            file://50-reservlocalport.conf \
           "

do_install:append:broadband() {
        install -m 644 ${WORKDIR}/50-reservlocalport.conf ${D}${sysconfdir}/sysctl.d
}

FILES:${PN}:append:broadband = " ${sysconfdir}/sysctl.d/50-reservlocalport.conf "

#meta-rdk-comcast/recipes-core/systemd/systemd_%.bbappend

inherit comcast-package-deploy

def get_download_apps(d):
    download_apps = d.getVar("BPN", True) + '-analyze'
    mlprefix = d.getVar("MLPREFIX", True).strip()
    print("mlprefix is [%s]" %mlprefix)
    if bb.utils.contains("DISTRO_FEATURES", "rdm mixmode", True, False, d):
        if mlprefix != "" :
            return download_apps
    elif bb.utils.contains("DISTRO_FEATURES", "rdm", True, False, d):
        return download_apps
    return ""

DOWNLOAD_APPS = "${@get_download_apps(d)}"
CUSTOM_PKG_EXTNS = "analyze"
SKIP_MAIN_PKG = "yes"
DOWNLOAD_ON_DEMAND = "yes"
DOWNLOAD_METHOD_CONTROLLER = "RFC"
#meta-rdk-comcast/recipes-core/systemd/systemd_250.5.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:${THISDIR}/${BPN}:"

### TBD evaluate if needed for systemd250
SRC_URI += "file://systemd250-tmpfiles.patch \
            file://systemd250-forec-reboot-on-freeze.patch \
            file://0001-Added-code-to-cleanup-all-the-xisting-watches-on-pat.patch \
            file://0001-Added-decrement-of-notify-watchers-when-we-dont-need_systemd250.patch \
            file://0001-Added-Extra-information-for-NTP-Status-250.patch  \
            file://systemd250-ntp-event-trigger.patch \
            file://0001-In-our-echo-system-we-are-managing-last-known-good-t-250.patch \
            file://0001_systemd250_reduce_journal_rotation_logging.patch \
            "

PACKAGECONFIG:append = " timesyncd"
#PACKAGECONFIG[timesyncd] = "--enable-timesyncd,--disable-timesyncd"


do_install:append() {
        install -d ${D}/media/tsb
	#Enable comcast ntp server in timesyncd.conf
	if [ -n "${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'timesyncd', '', d)}" ]; then
	   sed -i -e 's/^#NTP=.*/NTP=ntp.ccp.xcal.tv/g' ${D}${sysconfdir}/systemd/timesyncd.conf
           #Patch for CISCOXI4-2785: remove ProtectSystem=full from systemd-timesyncd.service
           sed -i -e '/ProtectSystem=/a ReadWritePaths=\/tmp' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e '/PrivateTmp=yes/d' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
	   sed -i -e 's/ExecStart=\!\!\/lib\/systemd\/systemd-timesyncd/ExecStartPre=\!\!\/bin\/sh -c \/lib\/rdk\/default-time-setter.sh\n&/' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^LockPersonality=yes.*/LockPersonality=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^MemoryDenyWriteExecute=yes.*/MemoryDenyWriteExecute=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^NoNewPrivileges=yes.*/NoNewPrivileges=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^PrivateDevices=yes.*/PrivateDevices=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectProc=invisible.*/ProtectProc=default/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectControlGroups.*/ProtectControlGroups=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectHome=yes.*/ProtectHome=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectHostname=yes.*/ProtectHostname=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectKernelLogs=yes.*/ProtectKernelLogs=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectKernelModules=yes.*/ProtectKernelModules=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^ProtectKernelTunables=yes.*/ProtectKernelTunables=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^RestrictNamespaces=yes.*/RestrictNamespaces=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^RestrictRealtime=yes.*/RestrictRealtime=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
           sed -i -e 's/^RestrictSUIDSGID=yes.*/RestrictSUIDSGID=false/g' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
	   sed -i -e 's/^#ShutdownWatchdogSec=.*$/ShutdownWatchdogSec=1min/g' ${D}${sysconfdir}/systemd/system.conf
       fi

}


do_install:append:hybrid() {
	#Enable comcast ntp server in timesyncd.conf
	if [ -n "${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'timesyncd', '', d)}" ]; then
	   sed -i -e 's/ExecStart=\!\!\/lib\/systemd\/systemd-timesyncd/ExecStart=\!\!\/bin\/sh -c \/bin\/echo systemd-timesyncd not needed in gateways/' ${D}${systemd_unitdir}/system/systemd-timesyncd.service
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

do_install:append:broadband(){
	rm -rd ${D}/media/tsb
}

FILES:${PN}:append:client = " /media/tsb"
FILES:${PN}:append:hybrid = " /media/tsb"

#meta-rdk-comcast-broadband/recipes-core/systemd/systemd_%.bbappend

DESCRIPTION = "File to mount /tmp with required options"

SRC_URI:append:broadband = " file://0001-no-exec-mount-opt-shm_v250.patch"

do_install:append:broadband() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'benchmark_enable', 'false', 'true', d)}; then
       sed -i -e 's/Options=/Options=nosuid,nodev,noexec,/' ${D}${systemd_unitdir}/system/tmp.mount
    fi
}

do_install:append:broadband() {
    #journal config override
    sed -i -e 's/.*SystemMaxFiles=.*/SystemMaxFiles=4/g' ${D}${sysconfdir}/systemd/journald.conf
    sed -i -e 's/.*RuntimeMaxFiles=.*/RuntimeMaxFiles=4/g' ${D}${sysconfdir}/systemd/journald.conf
}

#meta-rdk-ext/recipes-core/systemd/systemd_%.bbappend
include ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-profile', 'profiles/rdk-${BPN}-profile.inc', 'profiles/generic-profile.inc', d)}


PACKAGECONFIG:remove = "vconsole ldconfig resolved nss-resolve"
PACKAGECONFIG:remove:kirkstone = "${@bb.utils.contains('DISTRO_FEATURES', 'networkd-support', '', 'networkd', d)}"

PACKAGECONFIG:remove:libc-uclibc = "sysusers machined"
DEPENDS += " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " apparmor", "" ,d)}"
PACKAGECONFIG:append = " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " apparmor", "" ,d)}"

EXTRA_OECONF += "--disable-ldconfig"
EXTRA_OECONF:append:libc-uclibc = " --disable-sysusers --disable-machined "

CFLAGS:append:arm = " -fno-lto"

SRC_URI += " \
	    file://50-coredump.conf \
	    file://50-panic.conf \
	    file://50-netfilter.conf \
           file://50-portreserv.conf \
           file://traffic-filter.conf \
           file://protected_regular.conf \
           "
SRC_URI:append = " \
            file://usb-mount@.service \
            file://usb-mount.sh \
            file://99-usb-mount.rules \
           "
BACKPORTS ?= " "

RRECOMMENDS:${PN} += " \
        util-linux-swaponoff util-linux-losetup \
        util-linux-libmount util-linux-umount \
"

PACKAGES =+ "${PN}-usb-support"

FILES:${PN}-usb-support = " \
        /usb \
        /usb0 \
        /usb1 \
        ${systemd_unitdir}/system/usb-mount@.service \
        ${sbindir}/usb-mount.sh \
        ${sysconfdir}/udev/rules.d/99-usb-mount.rules \
        ${rootlibexecdir}/udev/rules.d/99-usb-mount.rules \
       "

FILES:${PN}:append = " ${datadir}/bash-completion"
FILES:${PN}:append = " ${sbindir}/usb-mount.sh"

do_install:append() {
	install -d ${D}${sysconfdir}/sysctl.d
	install -d ${D}${localstatedir}/lib/systemd/coredump
	install -m 644 ${WORKDIR}/50-coredump.conf ${D}${sysconfdir}/sysctl.d
	install -m 644 ${WORKDIR}/50-panic.conf ${D}${sysconfdir}/sysctl.d
	install -m 644 ${WORKDIR}/50-netfilter.conf ${D}${sysconfdir}/sysctl.d
	install -m 644 ${WORKDIR}/traffic-filter.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/protected_regular.conf ${D}${sysconfdir}/sysctl.d
        mkdir -pv ${D}/usb
        mkdir -pv ${D}/usb0
        mkdir -pv ${D}/usb1
        install -D -m 0644 ${S}/../usb-mount@.service ${D}${systemd_unitdir}/system/usb-mount@.service
        install -D -m 0755 ${S}/../usb-mount.sh ${D}${sbindir}/usb-mount.sh
        install -D -m 0644 ${S}/../99-usb-mount.rules ${D}${sysconfdir}/udev/rules.d/99-usb-mount.rules
        install -D -m 0644 ${S}/../99-usb-mount.rules ${D}${rootlibexecdir}/udev/rules.d/99-usb-mount.rules
        ln -s /dev/null ${D}${sysconfdir}/udev/rules.d/80-net-setup-link.rules

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

do_install:append() {
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-fsck
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-fsck*.service
}

do_install:append:client() {
        install -d ${D}/media/apps
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-binfmt
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-binfmt.service
        rm -rf ${D}${rootlibexecdir}/systemd/systemd-update-done
        rm -rf ${D}${rootlibexecdir}/systemd/system/systemd-update-done.service
        rm -rf ${D}${rootlibexecdir}/systemd/system/sysinit.target.wants/systemd-update-done.service
	sed -i '$a\net.ipv4.conf.all.send_redirects=0' ${D}${sysconfdir}/sysctl.d/traffic-filter.conf
        sed -i '$a\net.ipv4.conf.default.send_redirects=0' ${D}${sysconfdir}/sysctl.d/traffic-filter.conf
        sed -i '$a\net.ipv4.route.flush = 1' ${D}${sysconfdir}/sysctl.d/traffic-filter.conf
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-journal-catalog-update.service
        sed -i -e 's/systemd-update-done.service//g' ${D}${systemd_unitdir}/system/systemd-sysusers.service || true
}

do_install:append:hybrid() {
        install -d ${D}/media/apps
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
SYSTEMD_SERVICE:${PN} += "usb-mount@.service"
SYSTEMD_SERVICE:${PN}:remove:broadband = "usb-mount@.service"
FILES:${PN} += "${sysconfdir}/sysctl.d/50-coredump.conf \
                ${sysconfdir}/sysctl.d/50-panic.conf \
               "

FILES:${PN} += "${sysconfdir}/sysctl.d/50-netfilter.conf \
               "
FILES:${PN}:remove = "${bindir}/busctl ${datadir}/bash-completion/completions/busctl ${libdir}/libnss_mymachines.so.2 ${rootlibexecdir}/systemd/systemd-bus-proxyd ${rootlibexecdir}/systemd/systemd-ac-power ${rootlibexecdir}/systemd/systemd-fsck ${rootlibexecdir}/systemd/systemd-sleep ${rootlibexecdir}/systemd/system/systemd-fsck*.service ${rootlibexecdir}/systemd/systemd-reply-password ${rootlibexecdir}/systemd/systemd-activate"

FILES:${PN}:append:client = " /media/apps"
FILES:${PN}:append:hybrid = " /media/apps"
FILES:${PN}:append:hybrid = "${sysconfdir}/sysctl.d/50-portreserv.conf"
FILES:${PN} += "/media"
INSANE_SKIP:${PN} += "empty-dirs"

SYSTEMD_SERVICE:systemd-binfmt:remove:hybrid = " systemd-binfmt.service"
SYSTEMD_SERVICE:systemd-binfmt:remove:client = " systemd-binfmt.service"
#meta-rdk-ext/recipes-core/systemd/systemd_250.5.bbappend
include ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-profile', 'profiles/rdk-${BPN}-profile-${PV}.inc', 'profiles/generic-profile.inc', d)}

PACKAGECONFIG:remove = " pam idn quotacheck randomseed logind  hostnamed timedated localed resolve coredump tpm"

SRC_URI:append = " file://journalctl-250.patch \
                   file://0003-Remove-MS-constants-from-missing-header-file-250.patch \
                   file://10-ubi-device-systemd.rules \
                   file://99-default.preset \
                   file://0001-cgroup-downgrade-warning-if-we-can-t-get-ID-off-cgro.patch \
"

EXTRA_OECONF += " --enable-polkit=no"
PACKAGECONFIG:remove = "pam"
PACKAGECONFIG:append = " kmod"

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

do_install:append() {
    install -Dm 0644 ${WORKDIR}/99-default.preset ${D}${systemd_unitdir}/system-preset/99-default.preset
}
