FILESEXTRAPATHS:prepend_broadband := "${THISDIR}/files:"

SRC_URI:append:broadband = "\
                  file://0001-add-support-for-http-host-headers-cookie-url-netfilt.patch \
                  file://http_netfilter.cfg \
                 "

SRC_URI:remove_broadband = " file://0001-add-support-for-http-host-headers-cookie-url-netfilt.patch"

SRC_URI:append:broadband = " file://0001-http-headers-netfliter-dunfell.patch"
