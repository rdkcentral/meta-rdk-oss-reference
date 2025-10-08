
do_install:append() {
    # Rename all standard coreutils binaries to include .${BPN} suffix
    for cmd in ${base_bindir_progs} ${bindir_progs} ${sbindir_progs} df mktemp nice printenv base64; do
        for p in ${bindir} ${base_bindir} ${sbindir}; do
            if [ -f ${D}$p/$cmd ] && [ ! -f ${D}$p/$cmd.${BPN} ]; then
                mv -f ${D}$p/$cmd ${D}$p/$cmd.${BPN} || true
            fi
        done
    done

    # Special handling for '[' (bracket) since [.${BPN} breaks sed in update-alternatives
    if [ -f ${D}${bindir}/[ ]; then
        mv -f ${D}${bindir}/[ ${D}${bindir}/lbracket.${BPN} || true
    fi
}
