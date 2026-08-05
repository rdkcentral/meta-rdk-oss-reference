PACKAGECONFIG:remove = "vconsole"
#From meta-rdk-oem-element-amlogic
rootlibexecdir="${libdir}"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

BBCLASSEXTEND:append = " native nativesdk"

PACKAGECONFIG:remove += "backlight"


include ${@bb.utils.contains('DISTRO_FEATURES', 'systemd-profile', 'profiles/rdk-${BPN}-profile.inc', 'profiles/generic-profile.inc', d)}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:"

PACKAGECONFIG:remove = "vconsole ldconfig"
PACKAGECONFIG:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'networkd-support', '', 'networkd', d)}"
PACKAGECONFIG:remove = " resolved nss-resolve "

PACKAGECONFIG:remove_libc-uclibc = "sysusers machined"
DEPENDS += " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " apparmor", "" ,d)}"
PACKAGECONFIG[apparmor] = "-Dapparmor=enabled,-Dapparmor=disabled,apparmor"
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
BACKPORTS ?= " "

RDEPENDS:${PN} += " \
        util-linux-swaponoff util-linux-losetup \
        util-linux-libmount util-linux-umount \
"
PACKAGECONFIG:append = " kmod"

FILES:${PN}:append = " ${datadir}/bash-completion"

do_install:append() {
        install -d ${D}${sysconfdir}/sysctl.d
	install -d ${D}${localstatedir}/lib/systemd/coredump
        install -m 644 ${UNPACKDIR}/50-coredump.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${UNPACKDIR}/50-panic.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${UNPACKDIR}/50-netfilter.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${UNPACKDIR}/traffic-filter.conf ${D}${sysconfdir}/sysctl.d
        install -m 644 ${UNPACKDIR}/protected_regular.conf ${D}${sysconfdir}/sysctl.d
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
        #rm -rf ${D}${libdir}/libnss_mymachines.so.2
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
	sed -i -e '/^ExecStart=/ s/$/ --autologin root/' ${D}${systemd_unitdir}/system/serial-getty\@.service
}

do_install:append() {
        install -d ${D}${sysconfdir}/sysctl.d
        #install -m 0644 ${UNPACKDIR}/mmc.rules ${D}${sysconfdir}/udev/rules.d/
        rm -f ${D}/${sysconfdir}/systemd/network/20-wired.network
        #sed -i "s/Requires=.*/Requires=basic.target ui-init.target/g" ${D}${systemd_unitdir}/system/multi-user.target
        sed -i -e 's/.*RuntimeMaxUse=.*/RuntimeMaxUse=16M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's/.*RuntimeMaxFileSize=.*/RuntimeMaxFileSize=8M/g' ${D}${sysconfdir}/systemd/journald.conf
        sed -i -e 's@\(kernel.panic\)\(.*\)@\1 = 3@' ${D}${sysconfdir}/sysctl.d/50-panic.conf
        sed -i -e '$akernel.panic_on_oops = 1' ${D}${sysconfdir}/sysctl.d/50-panic.conf
}

SYSTEMD_SERVICE:systemd-binfmt:remove = " systemd-binfmt.service"
FILES:${PN} += "${sysconfdir}/sysctl.d/50-coredump.conf \
                ${sysconfdir}/sysctl.d/50-panic.conf \
               "

FILES:${PN} += "${sysconfdir}/sysctl.d/50-netfilter.conf \
               "
FILES:${PN}:remove = "${bindir}/busctl ${datadir}/bash-completion/completions/busctl ${rootlibexecdir}/systemd/systemd-bus-proxyd ${rootlibexecdir}/systemd/systemd-ac-power ${rootlibexecdir}/systemd/systemd-sleep ${rootlibexecdir}/systemd/systemd-reply-password ${rootlibexecdir}/systemd/systemd-activate"

FILES:${PN}:append = "/media"


# meta-rdk-comcast-video

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"


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

BBCLASSEXTEND:append = " native nativesdk"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:${THISDIR}/backports:${THISDIR}/${BPN}:"


PACKAGECONFIG:append = " timesyncd"
#PACKAGECONFIG[timesyncd] = "--enable-timesyncd,--disable-timesyncd"


do_install:append() {
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

ALTERNATIVE:${PN}:append = " init"

ALTERNATIVE_TARGET[init] = "${rootlibexecdir}/systemd/systemd"
ALTERNATIVE_LINK_NAME[init] = "${base_sbindir}/init"
ALTERNATIVE_PRIORITY[init] ?= "300"
PACKAGECONFIG:remove = "vconsole"
