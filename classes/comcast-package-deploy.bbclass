# Module should inherit this class to deploy its Package to CDL/CDN.

DESCRIPTION ?= "Package Deployment to CDN/CDL Server"
MODULE_NAME ?= "${PN}"
DEPLOYDIR = "${WORKDIR}/deploy-${PN}"
RDM_FLOCK = "${TMPDIR}/.rdmpkg.lock"

copy_rdm_package () {
    machine_name="${@d.getVar('MACHINE', True)}"
    module_name="${@d.getVar('MODULE_NAME', True)}"
    destn_dir="${@d.getVar('MODULE_NAME', True)}"
    arch="${@d.getVar('PACKAGE_ARCH', True)}"
    application_list="${@d.getVar('DOWNLOAD_APPS', True)}"
    ondemand_value="${@d.getVar('DOWNLOAD_ON_DEMAND', True)}"
    dwld_method_ctrl_value="${@d.getVar('DOWNLOAD_METHOD_CONTROLLER', True)}"
    rdm_pkg_type_value="${@d.getVar('RDM_PACKAGE_TYPE', True)}"
    package_extn_list="${@d.getVar('CUSTOM_PKG_EXTNS', True)}"
    skip_pkg_flag="${@d.getVar('SKIP_MAIN_PKG', True)}"
    pkg_name="${@d.getVar('PKG:%s' % MODULE_NAME, True)}"
    enable_rdm_versioning="${@d.getVar('ENABLE_RDM_VERSIONING', True)}"
    bundle_name="${@d.getVar('PKG_BUNDLE_NAME', True)}"
    bundle_major_version="${@d.getVar('PKG_BUNDLE_MAJOR_VERSION', True)}"
    bundle_minor_version="${@d.getVar('PKG_BUNDLE_MINOR_VERSION', True)}"
    decoupled_app="${@d.getVar('PKG_FIRMWARE_DECOUPLED', True)}"

    for app in `echo ${application_list}`; do


          for pkg_extn in `echo ${package_extn_list}`; do
               if [ -f ${TMPDIR}/deploy/ipk/${arch}/${PN}-${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ];then
                    if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
                       mkdir -p ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}
                    fi
                    flock -x "${RDM_FLOCK}" -c "cp  ${TMPDIR}/deploy/ipk/${arch}/${PN}-${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}"
               elif [ -f ${TMPDIR}/deploy/ipk/${arch}/${pkg_name}-${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ];then
                    if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
                       mkdir -p ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}
                    fi
                    flock -x "${RDM_FLOCK}" -c "cp  ${TMPDIR}/deploy/ipk/${arch}/${pkg_name}-${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}"
               #To add custom ipk files under a module where name of ipk files does not have module name as prefix
               elif [ -f ${TMPDIR}/deploy/ipk/${arch}/${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ];then
                    if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
                       mkdir -p ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}
                    fi
                    flock -x "${RDM_FLOCK}" -c "cp  ${TMPDIR}/deploy/ipk/${arch}/${pkg_extn}_${PKGV}-${PKGR}_${arch}.ipk ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}"
               fi
          done
          if [ ${skip_pkg_flag} != "yes" ];then
               if [ -f ${TMPDIR}/deploy/ipk/${arch}/${PN}_${PKGV}-${PKGR}_${arch}.ipk ];then
                    if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
                       mkdir -p ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}
                    fi
                    flock -x "${RDM_FLOCK}" -c "cp  ${TMPDIR}/deploy/ipk/${arch}/${PN}_${PKGV}-${PKGR}_${arch}.ipk ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}"
               elif [ -f ${TMPDIR}/deploy/ipk/${arch}/${pkg_name}_${PKGV}-${PKGR}_${arch}.ipk ];then
                    if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
                       mkdir -p ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}
                    fi
                    flock -x "${RDM_FLOCK}" -c "cp -n ${TMPDIR}/deploy/ipk/${arch}/${pkg_name}_${PKGV}-${PKGR}_${arch}.ipk ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}"
               fi
          fi

          if [ ! -d ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app} ];then
               echo "SnapShot for $app is not created"
          else
               # Strip off any unwanted spaces in these variables before processing them
               enable_rdm_versioning=$(echo ${enable_rdm_versioning} | xargs)
               decoupled_app=$(echo ${decoupled_app} | xargs)
               bundle_name=$(echo ${bundle_name} | xargs)
               bundle_major_version=$(echo ${bundle_major_version} | xargs)
               bundle_minor_version=$(echo ${bundle_minor_version} | xargs)

               if [ "${enable_rdm_versioning}" = "true" ];then
                    if [ -z "${bundle_name}" ] || [ -z "${bundle_major_version}" ] || [ -z "${bundle_minor_version}" ] || [ "${bundle_name}" = "None" ] || [ "${bundle_major_version}" = "None" ] || [ "${bundle_minor_version}" = "None" ];then
                         bbfatal_log "[RDM] RDM_VERSIONING distro is enabled but missing PKG_BUNDLE_NAME (and/or) PKG_BUNDLE_MAJOR_VERSION/PKG_BUNDLE_MINOR_VERSION"
                    else
                         echo "ENABLE_RDM_VERSIONING = ${enable_rdm_versioning}" > ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                         echo "PKG_BUNDLE_NAME = ${bundle_name}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                         bundle_version="${bundle_major_version}.${bundle_minor_version}"
                         echo "PKG_BUNDLE_VERSION = ${bundle_version}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config

                         if [ ${decoupled_app} != "None" ];then
                             echo "PKG_FIRMWARE_DECOUPLED = ${decoupled_app}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                         fi
                    fi
               fi

 
               if [ ${ondemand_value} != "None" ] && [ ${dwld_method_ctrl_value} != "None" ];then
                    if [ -f ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config ]; then
                        if (grep -q "DOWNLOAD_ON_DEMAND" ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config); then
                            bbnote "[RDM] DOWNLOAD_ON_DEMAND is already set in the rdm config for ${app} package. Hence overwriting it"
                            sed -i "/DOWNLOAD_ON_DEMAND/d" ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                        fi

                        if (grep -q "DOWNLOAD_METHOD_CONTROLLER" ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config); then
                            bbnote "[RDM] DOWNLOAD_METHOD_CONTROLLER is already set in the rdm config for ${app} package. Hence overwriting it"
                            sed -i "/DOWNLOAD_METHOD_CONTROLLER/d" ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                        fi
                    fi
                    echo "DOWNLOAD_ON_DEMAND = ${ondemand_value}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
                    echo "DOWNLOAD_METHOD_CONTROLLER = ${dwld_method_ctrl_value}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
               fi

               if [ ${rdm_pkg_type_value} != "None" ];then
                   echo "RDM_PACKAGE_TYPE = ${rdm_pkg_type_value}" >> ${TMPDIR}/deploy/${machine_name}/deploy-snapshots/${app}/config
               fi
          fi
    done
}

python deploy_rdm_package () {
    #package_get_auto_pr has to be invoked to get final PKGV, PKGR instead of default value
    bb.build.exec_func("package_get_auto_pr", d)
    bb.build.exec_func("copy_rdm_package", d)
}

python (){
    if bb.utils.contains('DISTRO_FEATURES', 'rdm', True, False, d):
        bb.note ("[RDM] Executing the function deploy_rdm_package")
        #Add deploy_rdm_package as a post function to both the clean and setscene do_package_write_ipk task
        d.appendVarFlag('do_package_write_ipk', 'postfuncs', ' deploy_rdm_package')
        d.appendVarFlag('do_package_write_ipk_setscene', 'postfuncs', ' deploy_rdm_package')
}

#Function to remove files from rootFS after adding as Runtime Download.
DOWNLOADABLE_PKG ?= "${PN}"

pkg_postinst:append:${DOWNLOADABLE_PKG}() {
    downloadable_file_list="${@d.getVar('DOWNLOADABLE_FILES', True) or ""}"
    if [ "x$downloadable_file_list" != "x" ]; then
        for file in ${downloadable_file_list}
        do
            if [ -n "$D" -a -d "$D" ]; then
                echo "Removing $file from rootfs"
                rm -rf $D/$file
            fi
        done
    fi
}
