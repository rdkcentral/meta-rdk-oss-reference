PACKAGECONFIG += " veritysetup "
PACKAGECONFIG[veritysetup] = "--enable-veritysetup,--disable-veritysetup"

PACKAGECONFIG:remove += "udev"

BBCLASSEXTEND = "native"
