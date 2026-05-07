FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://0001-su_INLINE-gcc-only-GNU-specifics-after-Og.patch \
           	    file://0001-su_INLINE-eh-no-give-up-share-detection.patch "
