DESCRIPTION = "This daemon is in charge of multiplexing connections over USB to an iPhone or iPod touch."

# Source revision points to 1.1.0 version of the repository.
SRCREV = "68bdf4be88b128c56eea5117361c4e7b51eb27b1"
#Pinned revison in usbmuxd recipe(.bb) file is to a version of the repository which is GPLv2 or GPLv3 licensed, not exclusively GPLv3.
LICENSE = "GPL-2.0-only & LGPL-2.1-only"

do_configure:prepend:wrynose() {

sed -i \
    -e '/PLIST_FORMAT_XML/d' \
    -e '/PLIST_FORMAT_BINARY/d' \
    ${RECIPE_SYSROOT}${includedir}/plist/plist.h
}
