SUMMARY = "ccronexpr library"
SECTION = "libs"
DESCRIPTION = "Library for ccronexpr"
HOMEPAGE = "https://github.com/staticlibs/ccronexpr"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=646c743a776a3dc373f94d63fb2f1a71"

SRC_URI = "git://github.com/staticlibs/ccronexpr.git;branch=master;protocol=https;nobranch=1 \
           file://0001-ccronexpr-cmakeLists.patch \
           file://0002-Add-CRON_USE_LOCAL_TIME-preprocessor-option.patch \
           "
SRCREV = "5d7e772df34aadc938f1246ebe2551b9c1c19012"


inherit cmake

TARGET_CFLAGS += "-DCRON_USE_LOCAL_TIME"
