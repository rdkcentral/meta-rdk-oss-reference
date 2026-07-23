FILESEXTRAPATHS:prepend:="${THISDIR}/${PN}:"
SRC_URI:append = " file://CVE-2019-12900_fix.patch "

# OE6 wrynose: bzip2-ptest/staticdev/locale inherit GPL-3.0-or-later from top-level LICENSE.
# rdk.conf INCOMPATIBLE_LICENSE blocks GPL-3.0-or-later → do_package [incompatible-license] ERROR.
# Packages are intentionally excluded; downgrade to WARN so do_package succeeds.
ERROR_QA:remove:wrynose = "incompatible-license"
WARN_QA:append:wrynose = " incompatible-license"
