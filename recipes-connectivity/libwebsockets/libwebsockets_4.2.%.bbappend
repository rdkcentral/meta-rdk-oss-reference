# Apply patch 919981fba64f45e563efddd833bdd01f63afa0a1 from libwebsockets "netlink: fix empty route index discovery"

FILESEXTRAPATHS:append := "${THISDIR}/files:"
SRC_URI:append = " file://empty_route_index.patch"
