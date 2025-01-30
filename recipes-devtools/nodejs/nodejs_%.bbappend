#removed brotli package in 12.14.1 version supported by dunfell
PACKAGECONFIG_remove = "brotli"

nodejs_package_preprocess () {
     machine_dir="${@d.getVar('MACHINE', True)}"
     echo "DEBUG: SPEEDTESTAPP: Machine: ${machine_dir}"
     mkdir -p ${TMPDIR}/deploy/nodejs/${machine_dir}/usr/bin
     install -m 0755 ${D}/usr/bin/node ${TMPDIR}/deploy/nodejs/${machine_dir}/usr/bin/

}
