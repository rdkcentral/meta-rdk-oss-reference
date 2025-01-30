SRC_URI_append = " file://0001-Add-sbr-buffer-flushing-for-aac-decoder-to-avoid-dir-gst1.18.patch \
                   file://0002-handling-sbr-header-extension-gst1.18.patch \
                 "

PACKAGECONFIG = " avcodec avformat swresample gpl avfilter avutil"

LICENSE_${PN} = "LGPLv2.1+"

PACKAGECONFIG_remove = "gpl x264"
