# libmount mountfd support requires openat2() (Linux >= 5.6); target kernel is 4.19
EXTRA_OECONF:append = " --disable-libmount-mountfd-support"

# uclampset uses struct sched_attr.sched_util_min/max, added in Linux 5.0 / glibc 2.29.
# On kernel 4.19, linux/sched/types.h defines only SCHED_ATTR_SIZE_VER0 (without uclamp
# fields) and sets SCHED_ATTR_SIZE_VER0, which prevents glibc's bits/sched.h from
# providing its own complete sched_attr.  Inject a shim linux/sched/types.h that omits
# SCHED_ATTR_SIZE_VER0, allowing glibc to define the full struct (with uclamp fields).
CFLAGS:append:class-target = " -I${WORKDIR}/sched-shim"

do_configure:prepend:class-target () {
    mkdir -p ${WORKDIR}/sched-shim/linux/sched
    cat > ${WORKDIR}/sched-shim/linux/sched/types.h <<'UL_SHIM_EOF'
/* Shim linux/sched/types.h injected by util-linux_%.bbappend for kernel 4.19.
 * Intentionally omits SCHED_ATTR_SIZE_VER0 and struct sched_attr so that
 * glibc's bits/sched.h provides the complete sched_attr with uclamp fields.
 */
#ifndef _LINUX_SCHED_TYPES_H
#define _LINUX_SCHED_TYPES_H
#include <linux/types.h>
struct sched_param {
	int sched_priority;
};
#endif /* _LINUX_SCHED_TYPES_H */
UL_SHIM_EOF
}

RRECOMMENDS:${PN}:remove = " \
                           ${PN}-addpart \ 
                           ${PN}-cfdisk \ 
                           ${PN}-chcpu \ 
                           ${PN}-chfn \ 
                           ${PN}-chmem \ 
                           ${PN}-choom \ 
                           ${PN}-chsh \ 
                           ${PN}-col \ 
                           ${PN}-colcrt \ 
                           ${PN}-colrm \ 
                           ${PN}-column \ 
                           ${PN}-ctrlaltdel \ 
                           ${PN}-delpart \ 
                           ${PN}-fincore \ 
                           ${PN}-findmnt \ 
                           ${PN}-fsck.cramfs \ 
                           ${PN}-hardlink \ 
                           ${PN}-ipcmk \ 
                           ${PN}-ipcrm \ 
                           ${PN}-ipcs \ 
                           ${PN}-irqtop \ 
                           ${PN}-isosize \ 
                           ${PN}-ldattach \ 
                           ${PN}-look \ 
                           ${PN}-lsblk \ 
                           ${PN}-lscpu \ 
                           ${PN}-lsipc \ 
                           ${PN}-lsirq \ 
                           ${PN}-lslocks \ 
                           ${PN}-lslogins \ 
                           ${PN}-lsmem \ 
                           ${PN}-lsns \ 
                           ${PN}-mkfs \ 
                           ${PN}-mkfs.cramfs \ 
                           ${PN}-namei \ 
                           ${PN}-partx \ 
                           ${PN}-rename \ 
                           ${PN}-resizepart \ 
                           ${PN}-scriptlive \ 
                           ${PN}-scriptreplay \ 
                           ${PN}-setarch \ 
                           ${PN}-setterm \ 
                           ${PN}-swaplabel \ 
                           ${PN}-uclampset \ 
                           ${PN}-ul \ 
                           ${PN}-uuidd \ 
                           ${PN}-uuidparse \ 
                           ${PN}-wdctl \ 
                           ${PN}-whereis \ 
                           ${PN}-write \ 
                           ${PN}-zramctl \
                          "               

# util-linux-ptest RDEPENDS on bash, bc, btrfs-tools, coreutils etc. as runtime test tools.
# These are not build-time DEPENDS. Suppress per-package QA check.
INSANE_SKIP:${PN}-ptest += "build-deps"
