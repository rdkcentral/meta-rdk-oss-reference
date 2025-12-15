FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://logrotate_memory_issues.patch \
                   file://logrotate-update-log-files.patch \
                   file://fix_fd_leak.patch \
                   file://logrotate_nohdd.conf \
                 "

# Create a dedicated configuration subpackage so logrotate config files
# can be managed/updated independently from the main ${PN} package.
PACKAGES =+ "${PN}-conf"

# Ship logrotate configuration files in ${PN}-conf.
FILES:${PN}-conf += "${sysconfdir}/logrotatemax.conf"
FILES:${PN}-conf += "${sysconfdir}/logrotate.conf"

# Remove these config files from the main package to avoid file conflicts.
FILES:${PN}:remove = "${sysconfdir}/logrotatemax.conf"
FILES:${PN}:remove = "${sysconfdir}/logrotate.conf"

do_install:append() {
    install -m 0644 ${WORKDIR}/logrotate_nohdd.conf ${D}${sysconfdir}/logrotatemax.conf
}
