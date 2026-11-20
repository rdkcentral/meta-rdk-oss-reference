#RDK-46317
RDEPENDS:${PN}-dev += " libpcre-dev libffi-dev"
RDEPENDS:${PN}-ptest:remove = "python3-dbusmock"

inherit breakpad-wrapper

