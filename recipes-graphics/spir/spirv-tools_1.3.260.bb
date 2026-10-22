require spirv-tools.inc

PV = "1.3.260"
# Note: PV tracks the Vulkan SDK version (1.3.260), but upstream does not
# provide an exact SPIR-V Tools tag for this SDK release. We therefore pin
# SRCREV to sdk-1.3.261.1, which is the closest published SPIR-V Tools drop
# corresponding to Vulkan SDK 1.3.260.
SRCREV = "e553b884c7c9febaa4e52334f683641fb5f196a0"
