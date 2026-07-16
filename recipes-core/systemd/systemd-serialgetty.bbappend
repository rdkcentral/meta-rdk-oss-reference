FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PV = "1.0.0"

do_install:prepend() {
    if [ -f "${UNPACKDIR}/serial-getty@.service" ]; then
	if [ -z `fgrep '\-\-autologin root' ${UNPACKDIR}/serial-getty\@.service` ]
	then
		sed -i -e '/^ExecStart=/ s/$/ --autologin root/' ${WORKDIR}/serial-getty\@.service
	fi
    fi
}

# From meta-middleware-development/recipes-xxx/recipes-core/systemd/systemd-serialgetty.bbappend
BBCLASSEXTEND:append = " nativesdk"
