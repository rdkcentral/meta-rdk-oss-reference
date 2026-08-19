#!/bin/sh
# apply-syslog-ng-template.sh

BOOT_ID_ENABLE="/opt/secure/RFC/enable_logchrono"
SYSLOG_NG_CONF="/tmp/syslog-ng.conf"

GENERAL_TEMPLATE='template-function t_rdk "${S_YEAR}-${S_MONTH}-${S_DAY}T${S_HOUR}:${S_MIN}:${S_SEC}.${S_MSEC}Z ${MSGHDR} ${MSG}";'
BOOTID_TEMPLATE='template-function t_rdk "$(substr ${.SDATA.journald._BOOT_ID} 0 8) ${.SDATA.journald.__MONOTONIC_TIMESTAMP} ${ISODATE} ${MSGHDR}${MSG}";'

# Do not block syslog-ng startup
[ -f "${SYSLOG_NG_CONF}" ] || exit 0

if [ -f "${BOOT_ID_ENABLE}" ]; then
    echo "Boot_id enabled: applying boot-id template"

    sed -i \
        "s|^[[:space:]]*template-function t_rdk.*|${BOOTID_TEMPLATE}|" \
        "${SYSLOG_NG_CONF}"
else
    echo "Boot_id disabled: applying general template"

    sed -i \
        "s|^[[:space:]]*template-function t_rdk.*|${GENERAL_TEMPLATE}|" \
        "${SYSLOG_NG_CONF}"
fi

exit 0
