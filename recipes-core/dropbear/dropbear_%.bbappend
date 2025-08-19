FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append() {
    	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}" = "systemd" ]; then
		sed -i -- '/EnvironmentFile=.*/a BindToDevice=${ESTB_INTERFACE}' ${D}${systemd_unitdir}/system/dropbear@.service
		sed -i -- '/EnvironmentFile=.*/a EnvironmentFile=/etc/device.properties' ${D}${systemd_unitdir}/system/dropbear@.service
	fi
}

#meta-rdk-comcast-broadband/recipes-core/dropbear/dropbear_%.bbappend
DEPENDS:append:broadband = " telemetry"
do_configure:prepend:broadband () {
    export LIBS="${LIBS} -ltelemetry_msgsender"
}
