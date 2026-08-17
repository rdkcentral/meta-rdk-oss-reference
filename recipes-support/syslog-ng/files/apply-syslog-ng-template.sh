#!/bin/sh
# apply-syslog-ng-template.sh
# Minimal: switch the first "template-function t_rdk" line in /tmp/syslog-ng.conf
# based on existence of /opt/secure/RFC/LogChrono_enabled.
# No backups, exits 0 on non-fatal errors so syslog-ng still starts.

BOOT_ID_ENABLE="/opt/secure/RFC/LogChrono_enabled"
SYSLOG_NG_CONF="/tmp/syslog-ng.conf"

GENERAL_TEMPLATE='template-function t_rdk "${S_YEAR}-${S_MONTH}-${S_DAY}T${S_HOUR}:${S_MIN}:${S_SEC}.${S_MSEC}Z ${MSGHDR} ${MSG}";'
BOOTID_TEMPLATE='template-function t_rdk "$(substr ${.SDATA.journald._BOOT_ID} 0 8) ${.SDATA.journald.__MONOTONIC_TIMESTAMP} ${ISODATE} ${MSGHDR}${MSG}";'

# If config not present, skip (do not block syslog-ng startup)
if [ ! -f "${SYSLOG_NG_CONF}" ]; then
  echo "WARN: ${SYSLOG_NG_CONF} not found; skipping template update." >&2
  exit 0
fi

# Choose template
if [ -f "${BOOT_ID_ENABLE}" ]; then
  NEW="${BOOTID_TEMPLATE}"
else
  NEW="${GENERAL_TEMPLATE}"
fi

# create tempfile (portable)
TMPDIR=${TMPDIR:-/tmp}
if tmpfile=$(mktemp "${TMPDIR}/apply-syslog-ng.XXXXXX" 2>/dev/null); then
  :
else
  tmpfile="${TMPDIR}/apply-syslog-ng.$$"
  : > "${tmpfile}" || { echo "ERROR: cannot create temp file" >&2; exit 0; }
fi

trap 'rm -f "${tmpfile}"' EXIT

# Replace only the first matching line, preserve leading indentation
awk -v new="$NEW" '
  BEGIN { changed=0 }
  {
    if (!changed && $0 ~ /^[[:space:]]*template-function t_rdk/) {
      match($0, /^[[:space:]]*/)
      indent = substr($0, RSTART, RLENGTH)
      print indent new
      changed = 1
    } else {
      print $0
    }
  }
' "${SYSLOG_NG_CONF}" > "${tmpfile}" || { echo "ERROR: writing temp file failed" >&2; exit 0; }

# Atomically replace the file
mv "${tmpfile}" "${SYSLOG_NG_CONF}" || { echo "ERROR: mv failed" >&2; exit 0; }

trap - EXIT

if [ -f "${BOOT_ID_ENABLE}" ]; then
  echo "Boot_id enabled: applied boot-id t_rdk template"
else
  echo "Boot_id disabled: applied general t_rdk template"
fi

exit 0
