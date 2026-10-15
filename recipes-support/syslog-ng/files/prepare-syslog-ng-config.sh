#!/bin/sh

ENABLE_LOGCHRONO="/opt/secure/RFC/enable_logchrono"
SYSLOG_NG_CONF="/tmp/syslog-ng.conf"

mkdir -p /tmp/syslog-ng
if [ ! -f "${SYSLOG_NG_CONF}" ]; then
   cp /etc/syslog-ng/syslog-ng.conf "${SYSLOG_NG_CONF}"
fi


MONOTONIC_TEMPLATE='template-function t_rdk "$(substr ${.SDATA.journald._BOOT_ID} 0 8) ${.SDATA.journald.__MONOTONIC_TIMESTAMP} ${S_YEAR}-${S_MONTH}-${S_DAY}T${S_HOUR}:${S_MIN}:${S_SEC}.${S_MSEC}Z ${MSGHDR} ${MSG}";'

[ -f "${SYSLOG_NG_CONF}" ] || exit 1

if [ -f "${ENABLE_LOGCHRONO}" ]; then
    sed -i \
        "s|^[[:space:]]*template-function t_rdk.*|${MONOTONIC_TEMPLATE}|" \
        "${SYSLOG_NG_CONF}"

fi

exit 0
