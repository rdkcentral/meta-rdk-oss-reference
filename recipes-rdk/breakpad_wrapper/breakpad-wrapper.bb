SUMMARY = "C wrapper for breakpad"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

SRC_URI = "${CMF_GITHUB_ROOT}/breakpad_wrapper;${CMF_GITHUB_BRANCH};name=breakpadwrapper"

DEPENDS += "breakpad"

SRCREV_breakpadwrapper = "9bf490d54050010f54f823cfa55022c18ad71363"
SRCREV_FORMAT = "breakpadwrapper"
PV = "1.0"

S = "${WORKDIR}/git/"

inherit autotools coverity

CPPFLAGS:append = " \
    -I${STAGING_INCDIR}/breakpad/ \
    "

LDFLAGS += "-lbreakpad_client -lpthread"

do_install:append () {
    # Config files and scripts
    install -d ${D}${includedir}/
    install -D -m 0644 ${S}/*.h ${D}${includedir}/
}


FILES:${PN} += "${libdir}/*.so"

CXXFLAGS += "-DMINIDUMP_RDKV"
