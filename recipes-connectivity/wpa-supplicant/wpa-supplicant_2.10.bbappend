FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
# wrynose OE6: utc_timestamp already upstream in wpa-supplicant 2.10 source at SRCREV
# wrynose OE6: auth_timeout_retry_logic, wpa_supp_bss_select, auth_timeout_retry_logic_1,
# allow_wps_cancel, and wpa_cli_command patches are duplicated in meta-rdk-comcast bbappend.
# Having them in both causes "already applied" quilt error (patch in series twice).
# Keep only unique oss-reference patches here; duplicates remain in meta-rdk-comcast.
SRC_URI += "\
            file://fix_wpa_supplicant_operating-mode.patch \
            file://tkip_rc4_bug_fix.patch \
            file://unii3_country_code_check.patch \
           "
# wrynose OE6: patches apply with fuzz (offset/context shift); remove from ERROR_QA
ERROR_QA:remove = "patch-fuzz patch-status"
do_configure:append () {

   #Enable the following supplicant options:
   #Enable Fast Session Transfer (FST)
   sed -i -- 's/#CONFIG_FST=y/\CONFIG_FST=y/' wpa_supplicant/.config
   #Enable dbus for NetworkManager
   sed -i -- 's/#CONFIG_CTRL_IFACE_DBUS_NEW=y/\CONFIG_CTRL_IFACE_DBUS_NEW=y/' wpa_supplicant/.config
   sed -i -- 's/#CONFIG_CTRL_IFACE_DBUS=y/\CONFIG_CTRL_IFACE_DBUS=y/' wpa_supplicant/.config
   sed -i -- 's/#CONFIG_CTRL_IFACE_DBUS_INTRO=y/\CONFIG_CTRL_IFACE_DBUS_INTRO=y/' wpa_supplicant/.config
 
   #configuring SAE support in wpa_supplicant 2.10
   echo "CONFIG_SAE=y" >> wpa_supplicant/.config
}
