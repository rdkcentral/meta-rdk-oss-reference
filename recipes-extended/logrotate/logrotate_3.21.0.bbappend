FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://logrotate_daemon_3_21_0.patch \
                   file://logrotate-update-service-files.patch \
                   file://logrotate_memory_issues.patch \
                   file://logrotate-update-log-files.patch \
                 "
