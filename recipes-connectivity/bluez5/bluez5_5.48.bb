require bluez5_5.48.inc

REQUIRED_DISTRO_FEATURES = "bluez5"

SRC_URI[md5sum] = "c9c853f3c90564cabec75ab35106c355"
SRC_URI[sha256sum] = "b9a8723072ef66bae7ec301c774902ebcb444c9c5b149b5a199e60a1ba970e90"

# noinst programs in Makefile.tools that are conditional on READLINE
# support
NOINST_TOOLS_READLINE ?= " \
    ${@bb.utils.contains('PACKAGECONFIG', 'deprecated', 'attrib/gatttool', '', d)} \
    tools/obex-client-tool \
    tools/obex-server-tool \
    tools/bluetooth-player \
    tools/obexctl \
    tools/btmgmt \
"

# noinst programs in Makefile.tools that are conditional on TESTING
# support
NOINST_TOOLS_TESTING ?= " \
    emulator/btvirt \
    emulator/b1ee \
    emulator/hfp \
    peripheral/btsensor \
    tools/3dsp \
    tools/mgmt-tester \
    tools/gap-tester \
    tools/l2cap-tester \
    tools/sco-tester \
    tools/smp-tester \
    tools/hci-tester \
    tools/rfcomm-tester \
    tools/bnep-tester \
    tools/userchan-tester \
"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}_${PV}:"

## Disable Patches
SRC_URI:remove = " \
    file://0001-hciattach-bcm43xx-fix-the-delay-timer-for-firmware-d.patch \
    file://cve-2017-1000250.patch \
    "

SRC_URI += "file://breakpad.patch \
    file://0001-testtools-fix-SIOCGSTAMP-undeclared-error.patch \
    file://0002-libexecdir-location.patch \
    file://bluez-5.48-035-avrcp-transport-volume-change.patch \
    file://bluez-5.48-038-bluez-stream-free-crash-fix.patch \
    file://bluez-5.48-040-bluez-btrmgr-crash.patch \
    file://bluez-5.48-041-clear_old_cache_list.patch \
    file://bluz5_5.48_gatt_db_service_crash.patch \
    file://bluez-5.48-046-prevent-scan-becoming-stuck.patch \
    file://bluez-5.48-047-Gen4-Crash-avoid.patch \
    file://bt_original_path_setup.sh \
    file://bluez-5.48-051-fix-for-incorrect-transaction-label.patch \
    file://bluez-5.48-052-bt_uuid_to_uuid128-crash.patch \
    file://bluez-5.48-055-kernel-dev-node-delete-create.patch \
    file://bluez-5.48-056-remove-pairing-failure-cache.patch \
    file://bluez-5.48-059-hci-version-update.patch \
"

SRC_URI:append = " file://bluez-5.48-kirkstone_compile_errors.patch "

SRC_URI += "file://0001-Fix-race-issue-with-tools-directory.patch \
            file://CVE-2019-8922.patch \
            file://CVE-2020-27153.patch \
            file://CVE-2022-0204.patch \
            file://CVE-2020-0556.patch \
            file://CVE-2018-10910.patch \
            file://CVE-2018-10910_I.patch \
            file://CVE-2019-8921.patch \
            file://CVE-2022-39176_5.48_fix.patch \
            file://CVE-2022-39177_5.48_fix.patch \
            file://CVE-2023-45866.patch \
            "

# noinst programs in Makefile.tools that are conditional on TOOLS
# support
NOINST_TOOLS_BT ?= " \
    tools/bdaddr \
    tools/avinfo \
    tools/avtest \
    tools/scotest \
    tools/amptest \
    tools/hwdb \
    tools/hcieventmask \
    tools/hcisecfilter \
    tools/btinfo \
    tools/btsnoop \
    tools/btproxy \
    tools/btiotest \
    tools/bneptest \
    tools/mcaptest \
    tools/cltest \
    tools/oobtest \
    tools/advtest \
    tools/seq2bseq \
    tools/nokfw \
    tools/create-image \
    tools/eddystone \
    tools/ibeacon \
    tools/btgatt-client \
    tools/btgatt-server \
    tools/test-runner \
    tools/check-selftest \
    tools/gatt-service \
    profiles/iap/iapd \
"
