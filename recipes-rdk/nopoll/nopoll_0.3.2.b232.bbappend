#generating minidumps symbols
inherit breakpad-wrapper
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://0001_nopoll_conn_new6_opts.patch"
SRC_URI += "file://0002_nopoll_conn_new_common_logs.patch"
SRC_URI += "file://0003_nopoll_transport_auto.patch"
