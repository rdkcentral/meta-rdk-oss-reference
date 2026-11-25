FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PV = "1.0.0"

do_install:prepend() {
	service_file="${S}/serial-getty@.service"
	if [ -f "$service_file" ] && ! grep -q -- '--autologin root' "$service_file"
	then
		sed -i -e '/^ExecStart=/ s/$/ --autologin root/' "$service_file"
	fi
}

# From meta-middleware-development/recipes-xxx/recipes-core/systemd/systemd-serialgetty.bbappend
BBCLASSEXTEND:append = " nativesdk"
