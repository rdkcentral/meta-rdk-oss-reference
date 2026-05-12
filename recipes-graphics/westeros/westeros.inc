LICENSE ?= "Apache-2.0"

PV = "1.0+gitr${SRCPV}"

#For Westeros recipe
WESTEROS_URI ?= "git://github.com/rdkcentral/westeros;protocol=https;nobranch=1;name=westeros"
SRCREV_westeros ?= "2.1.1"

#For westeros-sink
WESTEROS_SINK_URI ?= "git://github.com/rdkcentral/westeros-sink;protocol=https;nobranch=1;name=westeros-sink"
SRCREV_westeros-sink ?= "2.1.1"

#For essos
ESSOS_URI ?= "git://github.com/rdkcentral/essos;protocol=https;nobranch=1"
SRCREV_essos ?= "2.1.1"

LICENSE_LOCATION ?= "${S}/LICENSE"
LIC_FILES_CHKSUM ?= "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"

