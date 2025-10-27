#
# crate-fetch class
#
# Registers 'crate' method for Bitbake fetch2.
#
# Adds support for following format in recipe SRC_URI:
# crate://<packagename>/<version>
#

python __anonymous() {
    from bb.fetch2 import crate
    bb.fetch2.methods.append(crate.Crate())
}

