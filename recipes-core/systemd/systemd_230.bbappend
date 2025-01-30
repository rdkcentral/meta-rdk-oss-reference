FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " file://0001-Reduced-retry-interval-to-5-secs.patch \
             file://0002-udev-stop-freeing-value-afteru-using-it-for-setting-sysattr.patch \
             file://0003-udev-use-interface-before-the-string-is-freed.patch \
           "
