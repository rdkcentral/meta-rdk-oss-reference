#From meta-rdk-oem-element-amlogic

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://001_online_service_kirkstone.patch"
SRC_URI:append = " file://99_slaac.conf"
#SRC_URI:append = " file://mmc.rules"
SRC_URI:append = " file://004_rfkill_dependency_kirkstone.patch"

BBCLASSEXTEND:append = " native nativesdk"

PACKAGECONFIG:remove += "backlight"

# Override the default do_install for nativesdk build.
# Copy & pasted from ../openembedded-core/meta/recipes-core/systemd/systemd_230.bb, with a chown line removed

do_install:class-nativesdk() {
        autotools_do_install
        install -d ${D}/${base_sbindir}
        if ${@bb.utils.contains('PACKAGECONFIG', 'serial-getty-generator', 'false', 'true', d)}; then
                # Provided by a separate recipe
                rm ${D}${systemd_unitdir}/system/serial-getty* -f
        fi

        # Provide support for initramfs
        [ ! -e ${D}/init ] && ln -s ${rootlibexecdir}/systemd/systemd ${D}/init
        [ ! -e ${D}/${base_sbindir}/udevd ] && ln -s ${rootlibexecdir}/systemd/systemd-udevd ${D}/${base_sbindir}/udevd

        # Create machine-id
        # 20:12 < mezcalero> koen: you have three options: a) run systemd-machine-id-setup at install time, b) have / read-only and an empty file there (for stateless) and c) boot with / writable
        touch ${D}${sysconfdir}/machine-id


        install -d ${D}${sysconfdir}/udev/rules.d/
        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 0644 ${WORKDIR}/*.rules ${D}${sysconfdir}/udev/rules.d/
        install -d ${D}${libdir}/pkgconfig
        install -m 0644 ${B}/src/udev/udev.pc ${D}${libdir}/pkgconfig/

        install -m 0644 ${WORKDIR}/00-create-volatile.conf ${D}${sysconfdir}/tmpfiles.d/

        if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','true','false',d)}; then
                install -d ${D}${sysconfdir}/init.d
                install -m 0755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/systemd-udevd
                sed -i s%@UDEVD@%${rootlibexecdir}/systemd/systemd-udevd% ${D}${sysconfdir}/init.d/systemd-udevd
        fi

        # Delete journal README, as log can be symlinked inside volatile.
        rm -f ${D}/${localstatedir}/log/README

        install -d ${D}${systemd_unitdir}/system/graphical.target.wants
        install -d ${D}${systemd_unitdir}/system/multi-user.target.wants
        install -d ${D}${systemd_unitdir}/system/poweroff.target.wants
        install -d ${D}${systemd_unitdir}/system/reboot.target.wants
        install -d ${D}${systemd_unitdir}/system/rescue.target.wants

        # Create symlinks for systemd-update-utmp-runlevel.service
        if ${@bb.utils.contains('PACKAGECONFIG', 'utmp', 'true', 'false', d)}; then
                ln -sf ../systemd-update-utmp-runlevel.service ${D}${systemd_unitdir}/system/graphical.target.wants/systemd-update-utmp-runlevel.service
                ln -sf ../systemd-update-utmp-runlevel.service ${D}${systemd_unitdir}/system/multi-user.target.wants/systemd-update-utmp-runlevel.service
                ln -sf ../systemd-update-utmp-runlevel.service ${D}${systemd_unitdir}/system/poweroff.target.wants/systemd-update-utmp-runlevel.service
                ln -sf ../systemd-update-utmp-runlevel.service ${D}${systemd_unitdir}/system/reboot.target.wants/systemd-update-utmp-runlevel.service
                ln -sf ../systemd-update-utmp-runlevel.service ${D}${systemd_unitdir}/system/rescue.target.wants/systemd-update-utmp-runlevel.service
        fi

        # Enable journal to forward message to syslog daemon
        sed -i -e 's/.*ForwardToSyslog.*/ForwardToSyslog=yes/' ${D}${sysconfdir}/systemd/journald.conf
        # Set the maximium size of runtime journal to 64M as default
        sed -i -e 's/.*RuntimeMaxUse.*/RuntimeMaxUse=64M/' ${D}${sysconfdir}/systemd/journald.conf

        # this file is needed to exist if networkd is disabled but timesyncd is still in use since timesyncd checks it
        # for existence else it fails
        if [ -s ${D}${exec_prefix}/lib/tmpfiles.d/systemd.conf ]; then
                ${@bb.utils.contains('PACKAGECONFIG', 'networkd', ':', 'sed -i -e "\$ad /run/systemd/netif/links 0755 root root -" ${D}${exec_prefix}/lib/tmpfiles.d/systemd.conf', d)}
        fi
        if ! ${@bb.utils.contains('PACKAGECONFIG', 'resolved', 'true', 'false', d)}; then
                # if resolved is disabled, it won't handle the link of resolv.conf, so
                # set it up ourselves
                ln -s ../run/resolv.conf ${D}${sysconfdir}/resolv.conf
                echo 'L! ${sysconfdir}/resolv.conf - - - - ../run/resolv.conf' >>${D}${exec_prefix}/lib/tmpfiles.d/etc.conf
                echo 'f /run/resolv.conf 0644 root root' >>${D}${exec_prefix}/lib/tmpfiles.d/systemd.conf
        fi
        install -Dm 0755 ${S}/src/systemctl/systemd-sysv-install.SKELETON ${D}${systemd_unitdir}/systemd-sysv-install
}


FILES:${PN}:remove = "${sysconfdir}/systemd/network/20-wired.network"

# From meta-rdk-ext

include ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-profile', 'profiles/rdk-${BPN}-profile.inc', 'profiles/generic-profile.inc', d)}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:"

PACKAGECONFIG:remove = "vconsole ldconfig"
PACKAGECONFIG:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'networkd-support', '', 'networkd', d)}"
PACKAGECONFIG:remove = " resolved nss-resolve "

PACKAGECONFIG:remove_libc-uclibc = "sysusers machined"
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
#SRC_URI:append = " \
#            file://build-sys-add-check-for-gperf-lookup-function-signat.patch \
#           "
BACKPORTS ?= " "

RRECOMMENDS:${PN} += " \
        util-linux-swaponoff util-linux-losetup \
        util-linux-libmount util-linux-umount \
"
PACKAGECONFIG:append = " kmod"

FILES:${PN}:append = " ${datadir}/bash-completion"

do_install:append() {
        install -d ${D}${sysconfdir}/sysctl.d
	install -d ${D}${localstatedir}/lib/systemd/coredump
        install -m 644 ${WORKDIR}/50-coredump.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/50-panic.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/50-netfilter.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/traffic-filter.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/protected_regular.conf ${D}${sysconfdir}/sysctl.d
        #mkdir -pv ${D}/usb
        #mkdir -pv ${D}/usb0
        #mkdir -pv ${D}/usb1
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
        install -d ${D}${sysconfdir}/sysctl.d
        install -m 644 ${WORKDIR}/99_slaac.conf ${D}${sysconfdir}/sysctl.d
        #install -m 0644 ${WORKDIR}/mmc.rules ${D}${sysconfdir}/udev/rules.d/
        rm -f ${D}/${sysconfdir}/systemd/network/20-wired.network
        #sed -i "s/Requires=.*/Requires=basic.target ui-init.target/g" ${D}${systemd_unitdir}/system/multi-user.target
        sed -i -e 's/.*RuntimeMaxUse=.*/RuntimeMaxUse=16M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFileSize=.*/RuntimeMaxFileSize=8M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's@\(kernel.panic\)\(.*\)@\1 = 3@' ${D}${sysconfdir}/sysctl.d/50-panic.conf
        sed -i -e '$akernel.panic_on_oops = 1' ${D}${sysconfdir}/sysctl.d/50-panic.conf
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
FILES:${PN} += "${sysconfdir}/sysctl.d/50-coredump.conf \
                ${sysconfdir}/sysctl.d/50-panic.conf \
               "

FILES:${PN} += "${sysconfdir}/sysctl.d/50-netfilter.conf \
               "
FILES:${PN}:remove = "${bindir}/busctl ${datadir}/bash-completion/completions/busctl ${libdir}/libnss_mymachines.so.2 ${rootlibexecdir}/systemd/systemd-bus-proxyd ${rootlibexecdir}/systemd/systemd-ac-power ${rootlibexecdir}/systemd/systemd-sleep ${rootlibexecdir}/systemd/systemd-reply-password ${rootlibexecdir}/systemd/systemd-activate"

FILES:${PN}:append:client = " /media/apps"
FILES:${PN}:append:hybrid = " /media/apps"
FILES:${PN}:append:hybrid = "${sysconfdir}/sysctl.d/50-portreserv.conf"
FILES:${PN}:append = "/media"


# meta-rdk-comcast-video

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
                 file://0001-no-exec-mount-opt-shm_v250.patch \
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

FILES:${PN}:append = " /media/tsb"

#Exclude /media from QA_EMPTY_DIRS to support comcast specific changes in systemd
QA_EMPTY_DIRS:remove = "/media"

#Commented for now check with Rakhil on the distro feature
#FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
#SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'usb-bluetooth', 'file://004_rfkill_dependency.patch', '', d)}"

BBCLASSEXTEND:append = " native nativesdk"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:${THISDIR}/${BPN}:"

### TBD evaluate if needed for systemd250
SRC_URI += "file://systemd250-tmpfiles.patch \
            file://systemd250-forec-reboot-on-freeze.patch \
            file://0001-Added-code-to-cleanup-all-the-xisting-watches-on-pat.patch \
            file://0001-Added-decrement-of-notify-watchers-when-we-dont-need_systemd250.patch \
            file://0001-Added-Extra-information-for-NTP-Status-250.patch  \
            file://systemd250-ntp-event-trigger.patch \
            file://0001-In-our-echo-system-we-are-managing-last-known-good-t-250.patch \
            ${@bb.utils.contains('DISTRO_FEATURES', 'systimemgr', ' file://systemtimemgr_ntp.patch', '', d)} \
            file://0001_systemd250_reduce_journal_rotation_logging.patch \
            "

PACKAGECONFIG:append = " timesyncd"
#PACKAGECONFIG[timesyncd] = "--enable-timesyncd,--disable-timesyncd"


do_install:append() {
        install -d ${D}/media/tsb
        #Enable comcast ntp server in timesyncd.conf
        if [ -n "${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'timesyncd', '', d)}" ]; then
           sed -i -e 's/^#NTP=.*/NTP=time.google.com/g' ${D}${sysconfdir}/systemd/timesyncd.conf
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
           sed -i -e 's/^#NTP=.*/NTP=time.google.com/g' ${D}${sysconfdir}/systemd/timesyncd.conf
       fi

}

do_install:append:broadband(){
        rm -rd ${D}/media/tsb
}

FILES:${PN}:append:client = " /media/tsb"

ALTERNATIVE:${PN}:append = " init"

ALTERNATIVE_TARGET[init] = "${rootlibexecdir}/systemd/systemd"
ALTERNATIVE_LINK_NAME[init] = "${base_sbindir}/init"
ALTERNATIVE_PRIORITY[init] ?= "300"
