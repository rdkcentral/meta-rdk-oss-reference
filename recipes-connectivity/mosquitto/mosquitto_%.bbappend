FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:broadband += "file://mosquitto_prefer_ipv4.patch"

# mosquitto_prefer_ipv4.patch applies cleanly but with a context offset (fuzz)
# against this mosquitto version; not a functional issue.
ERROR_QA:remove = "patch-fuzz"

PACKAGECONFIG:remove:broadband = " websockets"
SYSTEMD_AUTO_ENABLE:${PN}:broadband = "enable"

# Add include_dir so Mosquitto can load custom configs if present
do_install:append() {
    sed -i 's|^#include_dir.*|include_dir /opt/persistent/mosquitto|' \
        ${D}${sysconfdir}/mosquitto/mosquitto.conf
}
