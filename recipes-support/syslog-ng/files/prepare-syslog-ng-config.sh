#!/bin/sh

mkdir -p /tmp/syslog-ng
if [ ! -f "${SYSLOG_NG_CONF}" ]; then
   cp /etc/syslog-ng/syslog-ng.conf "${SYSLOG_NG_CONF}"
fi

DISABLE_LOGCHRONO="/opt/secure/RFC/disable_logchrono"
SYSLOG_NG_CONF="/tmp/syslog-ng.conf"

GENERAL_TEMPLATE='template-function t_rdk "${S_YEAR}-${S_MONTH}-${S_DAY}T${S_HOUR}:${S_MIN}:${S_SEC}.${S_MSEC}Z ${MSGHDR} ${MSG}";'

[ -f "${SYSLOG_NG_CONF}" ] || exit 1

if [ -f "${DISABLE_LOGCHRONO}" ]; then
    sed -i \
        "s|^[[:space:]]*template-function t_rdk.*|${GENERAL_TEMPLATE}|" \
        "${SYSLOG_NG_CONF}"

fi

exit 0
