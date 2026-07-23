# wrynose: RPROVIDES:${PN} = "virtual/default-font" removed — the virtual-slash QA check
# (new in wrynose) rejects virtual/ in RPROVIDES as it has no meaning for runtime deps.
# Verified: nothing in any layer RDEPENDS on virtual/default-font at runtime, so no
# VIRTUAL-RUNTIME_default-font substitution is required.
PROVIDES = "virtual/default-font"
