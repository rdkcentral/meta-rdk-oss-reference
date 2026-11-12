SUMMARY = "Volatile bind mount setup and configuration for read-only-rootfs"
DESCRIPTION = "${SUMMARY}"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://mount-copybind \
    file://volatile-binds.service.in \
    file://var-lib.mount \
"

inherit allarch systemd features_check

REQUIRED_DISTRO_FEATURES = "systemd"

VOLATILE_BINDS ?= "\
    /var/volatile/lib /var/lib\n\
"
VOLATILE_BINDS[type] = "list"
VOLATILE_BINDS[separator] = "\n"

def volatile_systemd_services(d):
    services = []
    for line in oe.data.typed_value("VOLATILE_BINDS", d):
        if not line:
            continue
        what, where = line.split(None, 1)
        services.append("%s.service" % what[1:].replace("/", "-"))
    return " ".join(services)

SYSTEMD_SERVICE:${PN} = "${@volatile_systemd_services(d)}"

FILES:${PN} += "${systemd_unitdir}/system/*.service"

do_compile () {
    while read spec mountpoint; do
        if [ -z "$spec" ]; then
            continue
        fi

        servicefile="${spec#/}"
        servicefile="$(echo "$servicefile" | tr / -).service"
        sed -e "s#@what@#$spec#g; s#@where@#$mountpoint#g" \
            -e "s#@whatparent@#${spec%/*}#g; s#@whereparent@#${mountpoint%/*}#g" \
            volatile-binds.service.in >$servicefile
    done <<END
${@d.getVar('VOLATILE_BINDS', True).replace("\\n", "\n")}
END

    if [ -e var-volatile-lib.service ]; then
        # As the seed is stored under /var/lib, ensure that this service runs
        # after the volatile /var/lib is mounted.
        sed -i -e "/^Before=/s/\$/ systemd-random-seed.service/" \
               -e "/^WantedBy=/s/\$/ systemd-random-seed.service/" \
               var-volatile-lib.service
    fi

    if [ -e tmp-snmpd.conf.service ]; then
        sed -i -e '/^ConditionPathIsReadWrite=!/d' tmp-snmpd.conf.service
    fi
}
do_compile[dirs] = "${WORKDIR}"

do_install () {
    install -d ${D}${base_sbindir}
    install -m 0755 mount-copybind ${D}${base_sbindir}/

    install -d ${D}${systemd_unitdir}/system
    for service in ${SYSTEMD_SERVICE:${PN}}; do
        install -m 0644 $service ${D}${systemd_unitdir}/system/
    done
    install -m 0644 ${WORKDIR}/var-lib.mount ${D}${systemd_unitdir}/system/
}

do_install:append:broadband ()  {
    rm -f ${D}${systemd_unitdir}/system/var-lib.mount
}

do_install[dirs] = "${WORKDIR}"

SYSTEMD_SERVICE:${PN} += "var-lib.mount"
SYSTEMD_SERVICE:${PN}:remove:broadband += "var-lib.mount"
FILES:${PN}:remove:broadband += "${systemd_unitdir}/system/var-lib.mount"
