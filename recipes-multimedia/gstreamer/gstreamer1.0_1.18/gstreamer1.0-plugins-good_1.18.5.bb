require gstreamer1.0-plugins-common.inc

DESCRIPTION = "'Good' GStreamer plugins"
HOMEPAGE = "https://gstreamer.freedesktop.org/"
BUGTRACKER = "https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/issues"

#FILESPATH = "${FILE_DIRNAME}/gstreamer1.0-plugins-good"

SRC_URI = "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${PV}.tar.xz \
           file://0001-qt-include-ext-qt-gstqtgl.h-instead-of-gst-gl-gstglf.patch \
	   file://0001-gst-plugins-good-stubs-soft.h-not-existing-error.patch \
	   file://0001-qtdemux-add-senc-parser-gst1.18.patch \
	   file://0007-Fix-senc-subsample_count-gst1.18.patch \
	   file://0008-qtdemux-fix-signle-frame-processing-gst1.18.patch \
	   file://0009-qtdemux-aamp-tm-gst1.18.patch \
	   file://0011-matroskademux-Start-stream-time-at-zero-gst1.18.patch \
	   file://0012-qtdemux-add-atmos-mimetype-gst1.18.patch \
	   file://0012-matroskademux-emit-no-more-pads-when-the-Track-gst1.18.patch \
	   file://0013-qtdemux-remove-override-segment-event-gst1.18.patch \
	   file://0014-qtdemux-clear-crypto-info-on-trak-switch-gst1.18.patch \
	   file://0017-Clear-protected-flag-on-switching-tracks-gst1.18.patch \
	   file://0020-Initial-support-for-Dolby-Vision-gst1.18.patch \
	   file://0021-qtdemux-aamp-tm-multiperiod-gst1.18.patch \
	   file://0022-Manual-revert-of-bfd0e022-qtdemux-rework-seg-gst1.18.patch \
	   file://0023-qtdemux-add-context-for-a-preferred-protection-gst1.18.patch \
	   file://0024-qtdemux-restrict-segment-event-for-aamp-over-gst1.18.patch \
	   file://0031-qtdemux-aamp-fix-mp4a-atom-skip-gst1.18.patch \
	   file://0032-Avoid-sending-EOS-prematurely-for-live-stream-gst1.18.patch \
	   file://0033-adding-uuid-tag-gst1.18.patch \
	   file://0034-qtdemux-dont-error-with-no-protection-events-gst1.18.patch \
	   file://0035-qtdemux-check-ss_info-gst1.18.patch \
	   file://0037-qtdemux-aamp-avoid-unwanted-header-logging-gst1.18.patch \
           file://0038-fix-for-switching-from-clear-to-encrypted-and-vice-v.patch \
           file://0039-LLAMA-8596-Fix-for-demux-end-of-segment-detection.patch \
           file://0040-Migrate-soup3-capable-souphttpsrc-from-gstreamer-1.21.2.patch \
           file://0044-qtdemux-Don-t-emit-GstSegment-correcting-start-time-.patch \
           file://0045-qtdemux-Add-MSE-style-flush.patch \
           file://0046-qtdemux-Fix-crash-on-MSE-style-flush.patch \
           file://0040-check-return-caps-value-in-piff.patch \
           file://0001-added-support-for-cbcs-encryption-scheme.patch \
           file://0047-DELIA-61396-correct-sbc-rtp-timestamps.patch \
	   file://0048-Add-exposing-flag-to-know-if-configure_s.patch \
	   file://0013-qtdemux-Add-support-for-cenc-sample-grouping.patch \
	   file://0014-qtdemux-Fix-segfault-in-cenc-sample-grouping.patch \
	   file://0015-qtdemux-emit-no-more-pads-after-pruning-old-pads.patch \
	   file://0016-qtdemux-Fix-critical-message-on-cenc-sample-grouping.patch \
	   file://0017-Bring-back-sgpd-and-sbgp-dumps.patch \
	   file://0018-RDK-42832-Fix-crash-on-missing-protection-scheme-inf.patch \
	   file://0044-qtdemux-Handle-Piff-parsing-to-use-sample-properties.patch \
	   file://0001-reference-senc-box-when-saiz-box-parsing-fails.patch \
	   file://0049-LLAMA-12494-attach-cbcs-crypt-info-at-the-right-moment.patch \
           file://0001-Fix-leak-of-protection-event-value-objects.patch \
           "
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'sage_svp', 'file://0001-audioparser-remove-eac3-aacparse-for-svp.patch', '', d)}"

SRC_URI[sha256sum] = "3aaeeea7765fbf8801acce4a503a9b05f73f04e8a35352e9d00232cfd555796b"

S = "${WORKDIR}/gst-plugins-good-${PV}"

LICENSE = "GPL-2.0-or-later & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=a6f89e2100d9b6cdffcea4f398e37343 \
                    file://gst/replaygain/rganalysis.c;beginline=1;endline=23;md5=b60ebefd5b2f5a8e0cab6bfee391a5fe"

DEPENDS += "gstreamer1.0-plugins-base libcap zlib"
RPROVIDES:${PN}-pulseaudio += "${PN}-pulse"
RPROVIDES:${PN}-soup += "${PN}-souphttpsrc"
RPROVIDES:${PN}-soup3 += "${PN}-souphttpsrc"

PACKAGECONFIG ??= " \
    ${GSTREAMER_ORC} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'pulseaudio x11', 'pulseaudio x11', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'enable_libsoup3', 'soup3', 'soup', d)} \
    ${@bb.utils.contains('TUNE_FEATURES', 'm64', 'asm', '', d)} \
    bz2 cairo flac gdk-pixbuf jpeg libpng mpg123 speex taglib \
"

X11DEPENDS = "virtual/libx11 libsm libxrender libxfixes libxdamage"
X11ENABLEOPTS = "-Dximagesrc=enabled -Dximagesrc-xshm=enabled -Dximagesrc-xfixes=enabled -Dximagesrc-xdamage=enabled"
X11DISABLEOPTS = "-Dximagesrc=disabled -Dximagesrc-xshm=disabled -Dximagesrc-xfixes=disabled -Dximagesrc-xdamage=disabled"

QT5WAYLANDDEPENDS = "${@bb.utils.contains("DISTRO_FEATURES", "wayland", "qtwayland", "", d)}"

PACKAGECONFIG[asm]        = "-Dasm=enabled,-Dasm=disabled,nasm-native"
PACKAGECONFIG[bz2]        = "-Dbz2=enabled,-Dbz2=disabled,bzip2"
PACKAGECONFIG[cairo]      = "-Dcairo=enabled,-Dcairo=disabled,cairo"
PACKAGECONFIG[dv1394]     = "-Ddv1394=enabled,-Ddv1394=disabled,libiec61883 libavc1394 libraw1394"
PACKAGECONFIG[flac]       = "-Dflac=enabled,-Dflac=disabled,flac"
PACKAGECONFIG[gdk-pixbuf] = "-Dgdk-pixbuf=enabled,-Dgdk-pixbuf=disabled,gdk-pixbuf"
PACKAGECONFIG[gtk]        = "-Dgtk3=enabled,-Dgtk3=disabled,gtk+3"
PACKAGECONFIG[gudev]      = "-Dv4l2-gudev=enabled,-Dv4l2-gudev=disabled,libgudev"
PACKAGECONFIG[jack]       = "-Djack=enabled,-Djack=disabled,jack"
PACKAGECONFIG[jpeg]       = "-Djpeg=enabled,-Djpeg=disabled,jpeg"
PACKAGECONFIG[lame]       = "-Dlame=enabled,-Dlame=disabled,lame"
PACKAGECONFIG[libpng]     = "-Dpng=enabled,-Dpng=disabled,libpng"
PACKAGECONFIG[libv4l2]    = "-Dv4l2-libv4l2=enabled,-Dv4l2-libv4l2=disabled,v4l-utils"
PACKAGECONFIG[mpg123]     = "-Dmpg123=enabled,-Dmpg123=disabled,mpg123"
PACKAGECONFIG[pulseaudio] = "-Dpulse=enabled,-Dpulse=disabled,pulseaudio"
PACKAGECONFIG[qt5]        = "-Dqt5=enabled,-Dqt5=disabled,qtbase qtdeclarative qtbase-native ${QT5WAYLANDDEPENDS}"
PACKAGECONFIG[soup]       = "-Dsoup=enabled,-Dsoup=disabled,libsoup-2.4"
PACKAGECONFIG[soup3]      = "-Dsoup3=enabled,-Dsoup3=disabled,libsoup"
PACKAGECONFIG[speex]      = "-Dspeex=enabled,-Dspeex=disabled,speex"
PACKAGECONFIG[rpi]        = "-Drpicamsrc=enabled,-Drpicamsrc=disabled,userland"
PACKAGECONFIG[taglib]     = "-Dtaglib=enabled,-Dtaglib=disabled,taglib"
PACKAGECONFIG[v4l2]       = "-Dv4l2=enabled -Dv4l2-probe=true,-Dv4l2=disabled -Dv4l2-probe=false"
PACKAGECONFIG[vpx]        = "-Dvpx=enabled,-Dvpx=disabled,libvpx"
PACKAGECONFIG[wavpack]    = "-Dwavpack=enabled,-Dwavpack=disabled,wavpack"
PACKAGECONFIG[x11]        = "${X11ENABLEOPTS},${X11DISABLEOPTS},${X11DEPENDS}"

CFLAGS:append = " -flto -fuse-linker-plugin"
CXXFLAGS:append = " -flto -fuse-linker-plugin"
LDFLAGS:append = " -flto -fuse-linker-plugin"

EXTRA_OEMESON += " \
    -Ddoc=disabled \
    -Daalib=disabled \
    -Ddirectsound=disabled \
    -Ddv=disabled \
    -Dlibcaca=disabled \
    -Doss=disabled \
    -Doss4=disabled \
    -Dosxaudio=disabled \
    -Dosxvideo=disabled \
    -Dshout2=disabled \
    -Dtwolame=disabled \
    -Dwaveform=disabled \
    -Dgoom=disabled \
    -Dgoom2k1=disabled \
    -Ddtmf=disabled \
    -Dsmpte=disabled \
    -Ddebugutils=disabled \
    -Dy4m=disabled \
    -Dspectrum=disabled \
    -Dcutter=disabled \
    -Dmonoscope=disabled \
    -Dshapewipe=disabled \
    -Dwavenc=disabled \
    -Dreplaygain=disabled \
    -Deffectv=disabled \
    -Dvideobox=disabled \
"

FILES:${PN}-equalizer += "${datadir}/gstreamer-1.0/presets/*.prs"
