LICENSE = "Apache-2.0"

#SRC_URI = "${WESTEROS_URI}"
#SRCREV_westeros = "${WESTEROS_SRCREV}"

# Tip of westeros master as of Feb 26 2025 Westeros-1.01.58
#WESTEROS_SRCREV ?= "169eb0d501c814c0386573a4046990724a1d2fcb"



PV = "1.0+gitr${SRCPV}"

#For Westeros recipe
WESTEROS_URI ?= "git://github.com/rdkcentral/westeros;protocol=https;nobranch=1;name=westeros"
SRCREV_westeros ?= "2.1.0"

#For westeros-sink
WESTEROS_SINK_URI ?= "git://github.com/rdkcentral/westeros-sink;protocol=https;nobranch=1;name=westeros-sink"
SRCREV_westeros-sink ?= "2.1.0"

#For westeros-gl-drm
WESTEROS_SOC_URI ?= "git://github.com/rdkcentral/westeros-gl-drm;protocol=https;nobranch=1;name=westeros-soc"
SRCREV_westeros-soc ?= "2.1.0"

#For westeros-soc
#WESTEROS_SOC_URI ?= "git://github.com/rdkcentral/westeros-gl-brcm;protocol=https;nobranch=1"
#SRCREV_westeros-soc ?= "2.1.0"



#For essos
ESSOS_URI ?= "git://github.com/rdkcentral/essos;protocol=https;nobranch=1"
SRCREV_essos ?= "2.1.0"

LICENSE_LOCATION ?= "${S}/LICENSE"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"
