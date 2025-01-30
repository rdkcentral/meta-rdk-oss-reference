#This file will be included for yocto versions dunfell and higher.
LICENSE_FLAGS_ACCEPTED += "commercial_${MLPREFIX}gst-fluendo-mpegdemux \
                            commercial_${MLPREFIX}gst-ffmpeg \
                            ${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1_18','commercial_${MLPREFIX}ffmpeg','commercial_${MLPREFIX}libav',d)} \
                            commercial_${MLPREFIX}libomxil \
                            commercial_${MLPREFIX}gst-openmax \
                            commercial_${MLPREFIX}mpg123 \
                            commercial_${MLPREFIX}gstreamer1.0-omx \
                            commercial_${MLPREFIX}gstreamer1.0-libav"


# In order to build fdk-aac,ffmpeg,x264 please procure commercial license first
# The OSS does not build these IPK rather just provide the recipes to build these components
LICENSE_FLAGS_ACCEPTED += "commercial_${MLPREFIX}fdk-aac \
                            commercial_${MLPREFIX}ffmpeg \
                            commercial_${MLPREFIX}x264"

