# Add include_dir so Mosquitto can load custom configs if present
do_install:append() {
    sed -i 's|^#include_dir.*|include_dir /opt/persistent/mosquitto/mosquitto-test.conf|' \
        ${sysconfdir}/mosquitto/mosquitto.conf
}
