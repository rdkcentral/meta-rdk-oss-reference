SUMMARY = "Tensorflow Lite C Library"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

TENSORFLOW_RELEASE_BRANCH ?= "r2.13"

SRC_URI = "git://github.com/tensorflow/tensorflow;protocol=https;branch=${TENSORFLOW_RELEASE_BRANCH};name=xraudio-tensorflow-lite-lib \
           git://github.com/abseil/abseil-cpp;protocol=https;nobranch=1;name=abseil-cpp;destsuffix=abseil-cpp \
           git://gitlab.com/libeigen/eigen.git;protocol=https;nobranch=1;name=eigen;destsuffix=eigen \
           git://github.com/google/flatbuffers;protocol=https;nobranch=1;name=flatbuffers;destsuffix=flatbuffers \
           git://github.com/intel/ARM_NEON_2_x86_SSE;protocol=https;nobranch=1;name=neon2sse;destsuffix=neon2sse \
           git://github.com/pytorch/cpuinfo;protocol=https;nobranch=1;name=cpuinfo;destsuffix=cpuinfo \
           git://github.com/google/ruy;protocol=https;nobranch=1;name=ruy;destsuffix=ruy \
           git://github.com/google/farmhash;protocol=https;nobranch=1;name=farmhash;destsuffix=farmhash \
           git://github.com/petewarden/OouraFFT;protocol=https;nobranch=1;name=fft2d;destsuffix=fft2d \
           git://github.com/google/gemmlowp;protocol=https;nobranch=1;name=gemmlowp;destsuffix=gemmlowp"

SRCREV_xraudio-tensorflow-lite-lib = "${AUTOREV}"
SRCREV_abseil-cpp   = "b971ac5250ea8de900eae9f95e06548d14cd95fe"
SRCREV_eigen        = "b0f877f8e01e90a5b0f3a79d46ea234899f8b499"
SRCREV_flatbuffers  = "ee848a02e17a94edaacd1dd95a1664b59c6f06b2"
SRCREV_neon2sse     = "a15b489e1222b2087007546b4912e21293ea86ff"
SRCREV_cpuinfo      = "3dc310302210c1891ffcfb12ae67b11a3ad3a150"
SRCREV_ruy          = "3286a34cc8de6149ac6844107dfdffac91531e72"
SRCREV_farmhash     = "0d859a811870d10f53a594927d0d0b97573ad06d"
SRCREV_fft2d        = "c6fd2dd6d21397baa6653139d31d84540d5449a2"
SRCREV_gemmlowp     = "fda83bdc38b118cc6b56753bd540caa49e570745"

SRCREV_FORMAT = "xraudio-tensorflow-lite-lib"

S = "${WORKDIR}/git/tensorflow/lite/c/"
FILES_${PN}            += "${libdir}/libtensorflowlite_c.so"
INHIBIT_PACKAGE_STRIP   = "1"
INSANE_SKIP:${PN}       += "already-stripped"
SOLIBS                  = ".so"
FILES_SOLIBSDEV         = ""

ARM_VERSION ?= "armv7"

inherit cmake

do_install () {
   # Copy Library
   install -d ${D}${libdir}
   cp ${B}/libtensorflowlite_c.so               ${D}${libdir}
   # RDK-20060: Full stripping of ELF files (INHIBIT_PACKAGE_STRIP=1 so Yocto won't re-strip)
   ${TARGET_PREFIX}strip --strip-unneeded --remove-section=.comment ${D}${libdir}/libtensorflowlite_c.so || true

   # Copy headers
   cur=$(pwd)
   cd ${S}
   cd ../
   install -d ${D}${includedir}/tensorflow/lite/
   cp $(find . -maxdepth 1 -name "*.h*")        ${D}${includedir}/tensorflow/lite/
   cp --parents $(find ./c -name "*.h*")        ${D}${includedir}/tensorflow/lite/
   cp --parents $(find ./core/ -name "*.h*")    ${D}${includedir}/tensorflow/lite/
   cd ${cur}
}

do_configure:prepend() {
    # The main TFLite CMakeLists.txt hardcodes ${CMAKE_BINARY_DIR}/gemmlowp as
    # an include path. Since ${B} is wiped by cleandirs before do_configure, we
    # recreate the symlink here (after cleandir, before cmake invocation).
    mkdir -p ${B}
    ln -sf ${WORKDIR}/gemmlowp ${B}/gemmlowp
}

do_correct_toolchain_file() {
   sed -i "s/CMAKE_SYSTEM_PROCESSOR arm/CMAKE_SYSTEM_PROCESSOR ${ARM_VERSION}/g" ${WORKDIR}/toolchain.cmake
}

EXTRA_OECMAKE = " -DTFLITE_ENABLE_XNNPACK=OFF \
    -DFETCHCONTENT_SOURCE_DIR_ABSEIL-CPP=${WORKDIR}/abseil-cpp \
    -DFETCHCONTENT_SOURCE_DIR_EIGEN=${WORKDIR}/eigen \
    -DFETCHCONTENT_SOURCE_DIR_FLATBUFFERS=${WORKDIR}/flatbuffers \
    -DFETCHCONTENT_SOURCE_DIR_NEON2SSE=${WORKDIR}/neon2sse \
    -DFETCHCONTENT_SOURCE_DIR_CPUINFO=${WORKDIR}/cpuinfo \
    -DFETCHCONTENT_SOURCE_DIR_RUY=${WORKDIR}/ruy \
    -DFETCHCONTENT_SOURCE_DIR_FARMHASH=${WORKDIR}/farmhash \
    -DFETCHCONTENT_SOURCE_DIR_FFT2D=${WORKDIR}/fft2d \
    -DFETCHCONTENT_SOURCE_DIR_GEMMLOWP=${WORKDIR}/gemmlowp \
"
CFLAGS:append     = " -O3 -mfp16-format=ieee -lpthread"
CXXFLAGS:append   = " -O3 -mfp16-format=ieee -lpthread"
FC                = ""

LDFLAGS:append    = " -lpthread"

addtask correct_toolchain_file after do_generate_toolchain_file before do_configure

