FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PV = "1.0.0"

do_install:prepend() {
	if [ -z `fgrep '\-\-autologin root' ${WORKDIR}/serial-getty\@.service` ]
	then
		sed -i -e '/^ExecStart=/ s/$/ --autologin root/' ${WORKDIR}/serial-getty\@.service
	fi
}

# From meta-middleware-development/recipes-xxx/recipes-core/systemd/systemd-serialgetty.bbappend
BBCLASSEXTEND:append = " nativesdk"
