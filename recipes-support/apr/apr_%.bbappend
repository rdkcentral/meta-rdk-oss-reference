# apr-dev RDEPENDS on bash and libtool as runtime dev-package helpers.
# These are not build-time DEPENDS. Suppress the QA check per-package.
INSANE_SKIP:${PN}-dev += "build-deps"
