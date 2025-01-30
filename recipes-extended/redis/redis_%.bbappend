FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://redis-system.conf"
do_install:append() {
    sed -i 's|^dir /var/lib/redis/.*|dir /tmp/|' ${D}/${sysconfdir}/redis/redis.conf
    echo "unixsocket /tmp/redis.sock" >> ${D}${sysconfdir}/redis/redis.conf
    echo "unixsocketperm 666" >> ${D}${sysconfdir}/redis/redis.conf
    sed -i -e 's/^bind 127.0.0.1/#bind 127.0.0.1/' ${D}/${sysconfdir}/redis/redis.conf
    sed -i '/^appendonly yes/s/^/#/' ${D}${sysconfdir}/redis/redis.conf
    sed -i '/^appendfilename "appendonly.aof"/s/^/#/' ${D}${sysconfdir}/redis/redis.conf

    install -d ${D}${systemd_unitdir}/system/redis.service.d
    install -m 0644 ${WORKDIR}/redis-system.conf ${D}${systemd_unitdir}/system/redis.service.d/redis.conf

}
FILES:${PN} += "${systemd_unitdir}/system/redis.service.d/redis.conf"
