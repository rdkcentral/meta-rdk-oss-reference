SUMMARY = "JQuery"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://jquery-1.4.4.min.js;endline=15;md5=2c140a9bd07caf7410ede3295c3672fa"
PV = "1.0.0"
SRCREV = "0a863e17c601964a7b2afed71a9e781d43fdf8ec"
RDKE_GITHUB_ROOT = "git://git@github.com/rdk-e"
#SRC_URI = "${RDKE_GITHUB_ROOT}/jquery-opensource;${RDKE_GITHUB_SRC_URI_SUFFIX}"
#SRC_URI = "https://code.jquery.com/jquery-1.4.4.js"
SRC_URI = "https://code.jquery.com/jquery-1.4.4.min.js"
SRC_URI[sha256sum] = "b31cd094af7950b3a461dc78161fd2faf01faa9d0ed8c1c072790f83ab26d482"

S = "${WORKDIR}"


do_install() {
        install -m 0755 -d ${D}/var/www/htmldiag/js
        install -m 0755 -d ${D}/var/www/hwselftest/scripts
        install -m 0755 -d ${D}/var/www/htmldiag2/common/js
        install -m 0755 -d ${D}/var/www/shared
        
        # Creating symbol link to file jquery-1.4.4.min.js from shared folder.
        cp -a --no-preserve=ownership ${S}/jquery-1.4.4.min.js ${D}/var/www/shared
        ln -sf ../../shared/jquery-1.4.4.min.js ${D}/var/www/hwselftest/scripts/jquery-1.4.4.min.js
        ln -sf ../../shared/jquery-1.4.4.min.js ${D}/var/www/htmldiag/js/jquery-1.4.4.min.js
        ln -sf ../../../shared/jquery-1.4.4.min.js ${D}/var/www/htmldiag2/common/js/jquery-1.4.4.min.js
}

FILES:${PN} += " /var/www/shared \              
                 /var/www/htmldiag/js \
                 /var/www/htmldiag2/js \
                 /var/www/hwselftest/scripts \"

ALLOW_EMPTY:${PN} = "1"
