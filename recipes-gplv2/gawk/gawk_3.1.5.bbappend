#Add fix for fawk segmentation failure
SRC_URI:append = " file://gawk-3.1.5-segfault_fix.patch "

SRC_URI += "file://run-ptest"

inherit ptest

do_install_ptest() {
    mkdir -p ${D}${PTEST_PATH}/test
    for i in `grep -vE "@|^$|#|Gt-dummy" ${S}/test/Maketests |awk -F: '{print $1}'` Maketests; \
        do cp ${S}/test/$i* ${D}${PTEST_PATH}/test; \
    done
}
