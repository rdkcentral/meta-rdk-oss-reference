# ----------------------------------------------------------------------------
# Temp solution to support renaming of recipe from msgpackc -> msgpack-c
# Can be removed when all recipes which currently depend on msgpackc have
# been updated to depend on msgpack-c instead.
# ----------------------------------------------------------------------------

PROVIDES:broadband = "msgpackc"
RPROVIDES:${PN}:broadband += "msgpackc"

# ----------------------------------------------------------------------------
