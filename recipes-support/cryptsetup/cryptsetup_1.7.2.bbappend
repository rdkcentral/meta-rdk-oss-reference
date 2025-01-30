PACKAGECONFIG += " veritysetup "
PACKAGECONFIG[veritysetup] = "--enable-veritysetup,--disable-veritysetup"

PACKAGECONFIG_remove += "udev"

BBCLASSEXTEND = "native"
