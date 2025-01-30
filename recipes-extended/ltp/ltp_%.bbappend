FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0009-add-lava.patch \
            file://0010-fix-latency-calculation.patch \
            file://0011-remove-cpu-usage-from-cgroups.patch \
            file://0012-give-cpuctl_fj_cpu-hog-time-to-start.patch \
            file://0013-Measure-test-execution-time-and-present.patch \
           "

inherit ${@bb.utils.contains('DISTRO_FEATURES', 'rdm', 'comcast-package-deploy', '', d)}
DOWNLOAD_APPS="ltp"
DOWNLOADABLE_FILES="usr/ltp"

export prefix = "/usr/ltp"
export exec_prefix = "/usr/ltp"

do_install_append () {
    # No local kernel config, so these don't know quite what to do
    sed -e '/^acct02/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^quotactl01/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^quotactl04/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^quotactl06/d' -i ${D}${prefix}/runtest/syscalls

    # No <xfs/xqm.h>
    sed -e '/^quotactl02/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^quotactl03/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^quotactl05/d' -i ${D}${prefix}/runtest/syscalls

    # Cannot set Time Of Day with stack running
    sed -e '/^settimeofday01/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^settimeofday02/d' -i ${D}${prefix}/runtest/syscalls

    # RO rootfs breaks these since we cannot set log levels in /etc
    sed -e '/^syslog01/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog02/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog03/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog04/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog05/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog06/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog07/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog08/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog09/d' -i ${D}${prefix}/runtest/syscalls
    sed -e '/^syslog10/d' -i ${D}${prefix}/runtest/syscalls

    # No sudoers
    sed -e '/^utimensat01/d' -i ${D}${prefix}/runtest/syscalls

    # No swapoff
    sed -e '/^copy_file_range02/d' -i ${D}${prefix}/runtest/syscalls

    # EINVAL file open
    sed -e '/^aio02/d' -i ${D}${prefix}/runtest/io

    # This has problems with /proc/boops and faulting on access
    sed -e '/^proc01/d' -i ${D}${prefix}/runtest/fs
    sed -e '/^read_all_dev/d' -i ${D}${prefix}/runtest/fs

    # Not for 32 bit systems
    sed -e '/^max_map_count/d' -i ${D}${prefix}/runtest/mm

    # Needs wdev to be non-NULL
    sed -e '/^netns_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ip_ipv4_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ip_ipv6_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ip_ipv4_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ip_ipv6_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ns_exec_ipv6_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ns_exec_ipv6_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ip_ipv6_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ip_ipv4_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ip_ipv6_ioctl/d' -i ${D}${prefix}/runtest/containers

    # unable to create veth pair devices
    sed -e '/^netns_breakns_ns_exec_ipv4_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ns_exec_ipv6_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ns_exec_ipv4_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_breakns_ns_exec_ipv6_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ns_exec_ipv4_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ns_exec_ipv4_ioctl/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_comm_ip_ipv4_netlink/d' -i ${D}${prefix}/runtest/containers
    sed -e '/^netns_sysfs/d' -i ${D}${prefix}/runtest/containers
    
    # memcg write error: Device or resource busy
    sed -e '/^memcg_subgroup_charge/d' -i ${D}${prefix}/runtest/controllers
    sed -e '/^memcg_max_usage_in_bytes/d' -i ${D}${prefix}/runtest/controllers
    sed -e '/^memcg_stat/d' -i ${D}${prefix}/runtest/controllers
    sed -e '/^memcg_use_hierarchy/d' -i ${D}${prefix}/runtest/controllers
    sed -e '/^memcg_usage_in_bytes/d' -i ${D}${prefix}/runtest/controllers

    # root group's cpus isn't expected
    sed -e '/^cpuset_hotplug/d' -i ${D}${prefix}/runtest/controllers

    # Some filecaps broken
    sed -e '/^Filecaps/d' -i ${D}${prefix}/runtest/filecaps

    # Unrecognised flags in our busybox version
    sed -e '/^ar_sh/d' -i ${D}${prefix}/runtest/commands

    # No /dev/input/mice
    sed -e '/^input03/d' -i ${D}${prefix}/runtest/input

    # /dev/uinput isn't outputting the expected release
    sed -e '/^input06/d' -i ${D}${prefix}/runtest/input

    # Busybox dd: invalid status flag: `none' breaks fill
    sed -e '/^zram01/d' -i ${D}${prefix}/runtest/kernel_misc

    # moueX and mouseY Ev handlers missing
    sed -e '/^uevent03/d' -i ${D}${prefix}/runtest/uevent

    # BROK: adjtimex
    sed -e '/^leapsec01/d' -i ${D}${prefix}/runtest/syscalls

    sed -e '/^read_all_proc/d' -i ${D}${prefix}/runtest/fs

}

RDEPENDS_${PN}_remove = "\
        bash \
        cronie \
        gdb \
        procps \
    "

