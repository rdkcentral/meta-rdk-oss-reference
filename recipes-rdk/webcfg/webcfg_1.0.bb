SUMMARY = "webconfig client library"
HOMEPAGE = "https://github.com/xmidt-org/webcfg"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

DEPENDS = "cjson trower-base64 msgpack-c cimplog wdmp-c curl wrp-c"
DEPENDS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', ' rbus cpeabs', ' ', d)}"
DEPENDS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'aker', ' nanomsg libparodus ', '', d)}"

SRCREV = "e50f0bca386a7728b37271b05dcf207a3adde77a"
SRC_URI = "git://github.com/xmidt-org/webcfg.git;nobranch=1;protocol=https"

RDEPENDS:${PN} += "util-linux-uuidgen"

PV = "git+${SRCPV}"

ASNEEDED = ""

inherit pkgconfig cmake python3native

EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', '-DWEBCONFIG_BIN_SUPPORT=true', '', d)}"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'aker', '-DFEATURE_SUPPORT_AKER=true', '', d)}"
EXTRA_OECMAKE:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin mqttCM', '-DFEATURE_SUPPORT_MQTTCM=true', '', d)}"

LDFLAGS += "-lcjson -lmsgpackc -ltrower-base64 -lwdmp-c -lcimplog -lcurl -lwrp-c"
LDFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', ' -lrbus -lcpeabs ', ' ', d)}"
LDFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'aker', ' -llibparodus -lnanomsg ', '', d)}"

CFLAGS:append:wrynose = " -fcommon"

CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'multipartUtility', '-DMULTIPART_UTILITY', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'WanFailOverSupportEnable', ' -DWAN_FAILOVER_SUPPORTED ', ' ', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin mqttCM', '-DFEATURE_SUPPORT_MQTTCM', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'OneStack', ' -D_ONESTACK_PRODUCT_REQ_', '', d)}"
CFLAGS:append = " \
        -DBUILD_YOCTO \
        -I${STAGING_INCDIR}/wdmp-c \
        -I${STAGING_INCDIR}/cimplog \
        -I${STAGING_INCDIR}/trower-base64 \
        -I${STAGING_INCDIR}/wrp-c \
        -fPIC \
        "
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', '-I${STAGING_INCDIR}/rbus -I${STAGING_INCDIR}/rtmessage', '', d)}"
CFLAGS:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'aker', '-I${STAGING_INCDIR}/nanomsg -I${STAGING_INCDIR}/libparodus', '', d)}"
CFLAGS:append = " -Wno-format-truncation -Wno-sizeof-pointer-memaccess"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', 'file://webconfig_metadata.json', '', d)}"
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', 'file://webconfig_video_metadata.json', '', d)}"
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', 'file://metadata_parser.py', '', d)}"
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', 'file://webconfig.service', '', d)}"

do_install:append:broadband() {
    if ${@bb.utils.contains("DISTRO_FEATURES", "webconfig_bin", "true", "false", d)}
    then
      if ${@bb.utils.contains("DISTRO_FEATURES", "gateway_manager", "false", "true", d)}
      then
        sed -z 's/"name": "gwfailover",\n[[:blank:]]*"bitposition": 1,\n[[:blank:]]*"support": true,/"name": "gwfailover",\n"bitposition": 1,\n"support": false,/g' ${UNPACKDIR}/webconfig_metadata.json > ${UNPACKDIR}/out.txt
        mv ${UNPACKDIR}/out.txt ${UNPACKDIR}/webconfig_metadata.json
      fi
      install -d ${D}/usr/ccsp/webconfig
      install -d ${D}/etc
      touch ${D}/etc/WEBCONFIG_ENABLE
        if ${@bb.utils.contains("DISTRO_FEATURES", "OneStack", "true", "false", d)}
        then
            (${PYTHON} ${UNPACKDIR}/metadata_parser.py ${UNPACKDIR}/webconfig_metadata.json ${D}/etc/webconfig.properties.commercial ${MACHINE}_bci --one_stack)
            (${PYTHON} ${UNPACKDIR}/metadata_parser.py ${UNPACKDIR}/webconfig_metadata.json ${D}/etc/webconfig.properties.residential ${MACHINE} --one_stack)
        else
            (${PYTHON} ${UNPACKDIR}/metadata_parser.py ${UNPACKDIR}/webconfig_metadata.json ${D}/etc/webconfig.properties ${MACHINE})
        fi
    fi

    if ${@bb.utils.contains("DISTRO_FEATURES", "WanFailOverSupportEnable", "true", "false", d)}
    then
      touch ${D}/etc/CURRENT_INTERFACE
    fi
}

FILES_SOLIBSDEV = ""
FILES:${PN} += " ${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', '${exec_prefix}/ccsp/webconfig ${bindir}/*', '${libdir}/*.so', d)}"

ASNEEDED:hybrid = ""
ASNEEDED:client = ""
