SUMMARY = "FDK-AAC audio codec"

DESCRIPTION = "The Fraunhofer FDK AAC Codec Library for Android \
(\"FDK AAC Codec\") is software that implements the MPEG \
Advanced Audio Coding (\"AAC\") encoding and decoding scheme \
for digital audio."

LICENSE = "Fraunhofer_FDK_AAC_Codec_Library_for_Android"
HOMEPAGE = "https://www.iis.fraunhofer.de/en/ff/amm/impl.html"

LICENSE_FLAGS = "commercial"
LIC_FILES_CHKSUM = "file://NOTICE;md5=5985e1e12f4afa710d64ed7bfd291875"

SRC_URI = "git://github.com/mstorsjo/fdk-aac.git;protocol=https;branch=master"
#SRCREV = "d387d3b6ed79ff9a82c60440bdd86e6e5e324bec"
# Use lastest code as of 6/13/2023
SRCREV = "3f864cce9736cc8e9312835465fae18428d76295"

S = "${WORKDIR}/git"

SRC_URI[md5sum] = "fef453b5d6ee28ff302c600b8cded3e7"
SRC_URI[sha256sum] = "07c2a64b098eb48b2e9d729d5e778c08f7d22f28adc8da7c3f92c58da1cbbd8e"

inherit autotools

