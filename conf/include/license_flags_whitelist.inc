#This file will be included for yocto versions morty and daisy.
LICENSE_FLAGS_WHITELIST += "commercial_${MLPREFIX}gst-fluendo-mpegdemux \
                            commercial_${MLPREFIX}gst-ffmpeg \
                            ${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1_18','commercial_${MLPREFIX}ffmpeg','commercial_${MLPREFIX}libav',d)} \
                            commercial_${MLPREFIX}libomxil \
                            commercial_${MLPREFIX}gst-openmax \
                            commercial_${MLPREFIX}mpg123 \
                            commercial_${MLPREFIX}gstreamer1.0-omx \
                            commercial_${MLPREFIX}gstreamer1.0-libav"


LICENSE_FLAGS_WHITELIST += "commercial_${MLPREFIX}fdk-aac \
                            commercial_${MLPREFIX}ffmpeg \
                            commercial_${MLPREFIX}x264"

