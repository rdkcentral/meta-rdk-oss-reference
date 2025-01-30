FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Uncomment these lines and point to local copy of gperftools-2.6.tar.gz to inject local changes without patching
# Use this command or similar to update archive prior to building gperftools
# cd /home/dave/code/local/gperftools; rm gperftools-2.6.tar.gz; tar -czf gperftools-2.6.tar.gz gperftools-2.6; home; rm ../downloads/gperftools-2.6.tar.gz*; bitbake -fc fetch gperftools; rr gperftools
#FILESEXTRAPATHS:prepend := "/home/dave/code/local/gperftools:"
#SRC_URI = "file://gperftools-2.6.tar.gz"

SRC_URI:append:arm = " file://stacktrace_arm.patch "
SRC_URI:append = " file://001-run-heap-checker-after-fork.patch "

STACKTRACE_METHOD:arm = "arm"

ENV_FILE_TARGET="${sysconfdir}/environment"
SCR_FILE_TARGET="${bindir}/gperftools_env_leak.sh"
SCR_FILE_LOCAL="${WORKDIR}/gperftools_env_leak.sh"

FULL_OPTIMIZATION:remove = "${@bb.utils.contains('DISTRO_FEATURES_RDK', 'comcast-gperftools-heapcheck-wp', '-Og', '', d)}"

do_install:append() {
   # Create symbolic links to the binary locations expected by pprof
   ln -s /bin/env  ${D}${bindir}/env
   ln -s ${bindir}/${HOST_PREFIX}addr2line  ${D}${bindir}/addr2line
   ln -s ${bindir}/${HOST_PREFIX}objdump    ${D}${bindir}/objdump
   ln -s ${bindir}/${HOST_PREFIX}nm         ${D}${bindir}/nm
   ln -s ${bindir}/${HOST_PREFIX}c++filt    ${D}${bindir}/c++filt
   
   # Create a script to update environment file for leak checking
   echo "#!/bin/sh" > ${SCR_FILE_LOCAL}
   echo "echo \"HEAP_CHECK_IDENTIFY_LEAKS=true\" >> ${ENV_FILE_TARGET}" >> ${SCR_FILE_LOCAL}
   echo "echo \"HEAPCHECK=normal\" >> ${ENV_FILE_TARGET}" >> ${SCR_FILE_LOCAL}
   echo "echo \"TCMALLOC_STACKTRACE_METHOD=${STACKTRACE_METHOD}\" >> ${ENV_FILE_TARGET}" >> ${SCR_FILE_LOCAL}
   echo "echo \"PPROF_PATH=/usr/bin/pprof\" >> ${ENV_FILE_TARGET}" >> ${SCR_FILE_LOCAL}
   
   install -Dm 0755 ${SCR_FILE_LOCAL} ${D}${bindir}
}

FILES:${PN} += "${bindir}/env ${bindir}/addr2line ${bindir}/objdump ${bindir}/nm ${bindir}/c++filt ${SCR_FILE_TARGET}"
DOWNLOAD_APPS="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','debug_tools-gperftools',' ',d)}"
INHERIT_COMCAST_PACKAGE_DEPLOY := "${@bb.utils.contains('DISTRO_FEATURES', 'debugtools_rdm', 'comcast-package-deploy', '', d)}"
inherit ${INHERIT_COMCAST_PACKAGE_DEPLOY}
DOWNLOAD_ON_DEMAND="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','yes',' ',d)}"
DOWNLOAD_METHOD_CONTROLLER="${@bb.utils.contains('DISTRO_FEATURES','debugtools_rdm','RFC',' ',d)}"
