EXTRA_OECONF:append = " \
    --disable-everything \
    --disable-gpl \
    --disable-libx264 \
    --disable-ffprobe \
    --disable-ffmpeg \
    --disable-postproc \
    --disable-symver \
    --disable-doc \
    --disable-extra-warnings \
    --disable-bsf=dca_core \
    --disable-bsf=eac3_core \
    --disable-bsf=truehd_core \
    --disable-parser=mlp \
    --disable-parser=dca \
    --enable-libxml2                     \
    --disable-libsmbclient               \
    --disable-protocol=libsmbclient      \
    --enable-demuxer=aa  \
    --enable-demuxer=aac  \
    --enable-demuxer=aiff  \
    --enable-demuxer=amr  \
    --enable-demuxer=amrnb  \
    --enable-demuxer=amrwb  \
    --enable-demuxer=ape  \
    --enable-demuxer=asf  \
    --enable-demuxer=asf_o  \
    --enable-demuxer=au  \
    --enable-demuxer=avi  \
    --enable-demuxer=avs  \
    --enable-demuxer=caf  \
    --enable-demuxer=dsf  \
    --enable-demuxer=flac  \
    --enable-demuxer=flv  \
    --enable-demuxer=gsm  \
    --enable-demuxer=hls  \
    --enable-demuxer=live_flv  \
    --enable-demuxer=matroska  \
    --enable-demuxer=mov  \
    --enable-demuxer=mp3  \
    --enable-demuxer=mpc  \
    --enable-demuxer=mpc8  \
    --enable-demuxer=mpc8  \
    --enable-demuxer=mpegps  \
    --enable-demuxer=mpegts  \
    --enable-demuxer=mxf  \
    --enable-demuxer=ogg  \
    --enable-demuxer=pcm_alaw \
    --enable-demuxer=pcm_f32be \
    --enable-demuxer=pcm_f32le \
    --enable-demuxer=pcm_f64be \
    --enable-demuxer=pcm_f64le \
    --enable-demuxer=pcm_mulaw \
    --enable-demuxer=pcm_s16be \
    --enable-demuxer=pcm_s16le \
    --enable-demuxer=pcm_s24be \
    --enable-demuxer=pcm_s24le \
    --enable-demuxer=pcm_s32be \
    --enable-demuxer=pcm_s32le \
    --enable-demuxer=pcm_s8 \
    --enable-demuxer=pcm_u16be \
    --enable-demuxer=pcm_u16le \
    --enable-demuxer=pcm_u24be \
    --enable-demuxer=pcm_u24le \
    --enable-demuxer=pcm_u32be \
    --enable-demuxer=pcm_u32le \
    --enable-demuxer=pcm_u8 \
    --enable-demuxer=pcm_vidc \
    --enable-demuxer=rm  \
    --enable-demuxer=rtp  \
    --enable-demuxer=sbc  \
    --enable-demuxer=shorten  \
    --enable-demuxer=tta  \
    --enable-demuxer=voc  \
    --enable-demuxer=wav  \
    --enable-demuxer=wv  \
    --enable-decoder=aac \
    --enable-decoder=aac_fixed \
    --enable-decoder=aac_latm \
    --enable-decoder=alac \
    --enable-decoder=avs \
    --enable-decoder=flac \
    --enable-decoder=mp2 \
    --enable-decoder=mp2float \
    --enable-decoder=mp3 \
    --enable-decoder=mp3adu \
    --enable-decoder=mp3adufloat \
    --enable-decoder=mp3float \
    --enable-decoder=mp3on4 \
    --enable-decoder=mp3on4float \
    --enable-decoder=opus \
    --enable-decoder=ra_144 \
    --enable-decoder=ra_288 \
    --enable-decoder=ralf \
    --enable-decoder=sbc \
    --enable-decoder=vorbis \
    --enable-decoder=wmav1 \
    --enable-decoder=wmav2 \
    --enable-decoder=vp8 \
"

DEPENDS += " libxml2 "
RDEPENDS:${PN} += " libxml2 "

INSANE_SKIP:${PN} = "dev-so ldflags dev-elf"
INSANE_SKIP:${PN}-dev = "dev-so ldflags dev-elf"

FILES:${PN} += " ${libdir}/*.so ${libdir}/*.so.* "
FILES:${PN}-dev = "${includedir}/* ${libdir}/pkgconfig/*"
