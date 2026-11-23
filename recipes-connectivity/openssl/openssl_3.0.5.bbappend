FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://curl_patch_support_pkcs11_provider_3.0.5.patch"

