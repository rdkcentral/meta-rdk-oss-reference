FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}_${PV}:"

SRC_URI:append = " file://CVE-2022-42010_fix.patch \
                   file://CVE-2022-42012_fix.patch \
                   file://CVE-2022-42011_fix.patch \
                   file://CVE-2023-34969_fix.patch \
                 "

