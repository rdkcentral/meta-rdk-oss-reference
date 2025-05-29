require linux-libc-headers.inc

PV = "4.9"
SRC_URI:append = " file://v4l2.patch "
SRC_URI:append = " file://0001-install-dma-buf.h.patch "
SRC_URI:append = " file://0002-av-metrics-headers.patch "
SRC_URI:append = " file://0003-Idle_time_metricsV2.patch "
SRC_URI:append = " file://0004-android-binder.h-libc-5.4.patch "
SRC_URI:append = " file://0004-idle-metrics-v3.patch "
SRC_URI:append = " file://0005-av_metrics_V3.patch "

SRC_URI[md5sum] = "0a68ef3615c64bd5ee54a3320e46667d"
SRC_URI[sha256sum] = "029098dcffab74875e086ae970e3828456838da6e0ba22ce3f64ef764f3d7f1a"

