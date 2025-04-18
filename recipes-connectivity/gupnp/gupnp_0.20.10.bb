require recipes-connectivity/gupnp/gupnp_0.20.10.inc

SRC_URI = "http://download.gnome.org/sources/${BPN}/0.20/${BPN}-${PV}.tar.xz \
           file://delia-26739.patch \
           "
SRC_URI[md5sum] = "baf2201003253ec39a1d078a2f0fb96d"
SRC_URI[sha256sum] = "5c7f9278b50ed252606552e2f148be4e1b1616bc93ebc8b09b22fcf5d8aa08e4"
SRC_URI:append = " file://upnp-xi-ip-fetch-rdk-17191.patch"
SRC_URI:append = " file://0001-gupnp-binding-tool-use-python3.patch"
SRC_URI:append = " file://delia-42416.patch"
SRC_URI:append = " file://libgupnp-devprotection.patch"
SRC_URI:append = " file://0002-Delia-41161-gupnp.patch"
LIC_FILES_CHKSUM = "file://COPYING;md5=3bf50002aefd002f49e7bb854063f7e7 \
                    file://libgupnp/gupnp.h;beginline=1;endline=20;md5=d78a69d9b6e63ee2dc72e7b674d97520"

DEFAULT_PREFERENCE = "-1"

EXTRA_OECONF += "--enable-introspection=no"

RDEPENDS:${PN}-dev:append = " ${PYTHON_PN}"
RDEPENDS:${PN}-dev:remove_broadband = "python-textutils python-xml"
RDEPENDS:${PN}-dev:append = " ${PYTHON_PN}-xml ${PYTHON_PN}-core"
