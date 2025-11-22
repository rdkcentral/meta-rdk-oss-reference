FILESEXTRAPATHS:prepend:broadband := "${THISDIR}/files:"

SRC_URI:append:broadband = "\
                  file://http_netfilter.cfg \
                 "

SRC_URI:append:broadband = " file://0001-http-headers-netfliter-dunfell.patch"
