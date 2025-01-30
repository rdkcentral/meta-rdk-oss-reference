FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI +="\
           ${@bb.utils.contains('DISTRO_FEATURES', 'leak_sanitizer', 'file://0042-relax_DEEPBIND_for_sanitizer.patch', '', d)} \
           ${@bb.utils.contains('DISTRO_FEATURES', 'leak_sanitizer use_lsan', 'file://0043-lsan-support-arm.patch', '', d)} \  
          "
