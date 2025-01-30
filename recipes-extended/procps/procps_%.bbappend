
do_install:append() {
	PATH_TO_SYSCTL_DIR="${D}${sysconfdir}/sysctl.d/"
	if [ -d "${PATH_TO_SYSCTL_DIR}" ]; then
		# Remove unwanted configs installed if any
		rm -rf "${PATH_TO_SYSCTL_DIR}"
	fi

	PATH_TO_SYSCTL_CONF="${D}${sysconfdir}/sysctl.conf"
	if [ -f "${PATH_TO_SYSCTL_CONF}" ]; then
		# /etc/sysctl.conf can override all user configs. So make it null
		ln -sf /dev/null "${PATH_TO_SYSCTL_CONF}"
	fi
}
