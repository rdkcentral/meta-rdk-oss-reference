RDEPENDS:packagegroup-base-zeroconf = "\
    "

PACKAGES:remove = "nfs"
RDEPENDS:remove = "nfs"
RRECOMMENDS:packagegroup-base-nfs:remove = "kernel-module-nfs"
RDEPENDS:packagegroup-base-usbhost:remove = "usbutils"
