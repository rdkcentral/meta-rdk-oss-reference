require spirv-tools.inc

PV = "1.3.247"
# Note: this recipe uses the SPIR-V Tools SDK drop sdk-1.3.246.1, which ships as part of
# Vulkan SDK 1.3.247. PV is intentionally set to the Vulkan SDK version (1.3.247) rather
# than the SPIR-V SDK tag to follow the Vulkan SDK versioning convention in this layer.
SRCREV = "44d72a9b36702f093dd20815561a56778b2d181e"
