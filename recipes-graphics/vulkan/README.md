# Vulkan SDK Integration

This directory contains recipes for Vulkan SDK components used across STB and TV platforms in RDK.

## Integration Strategy

- RDK provides common, unmodified Khronos Vulkan components as external recipes:

| Component                 | Description                                    |
|---------------------------|------------------------------------------------|
| `vulkan-headers`          | Vulkan API headers from Khronos                |
| `vulkan-loader`           | Khronos Vulkan loader (`libvulkan.so`)         |
| `vulkan-tools`            | Vulkan info and utilities (`vulkaninfo`)       |
| `vulkan-validationlayers` | Optional validation layers for debugging       |

- SoC vendors are expected to:
  - Provide only their Vulkan **ICD JSON** and **driver**
  - Not include their own `libvulkan.so`

- All components are built via Yocto, and versioned recipes are maintained for platform-specific needs.

## OpenEmbedded-Core Integration

For version 1.3.204, this layer extends the recipes provided by the Yocto Kirkstone (OE-Core) layer:
- `vulkan-headers_1.3.204.1` - Uses OE-core recipe
- `vulkan-loader_1.3.204.1` - Uses OE-core recipe
- `vulkan-tools_1.3.204.1` - Uses OE-core recipe with custom patches via bbappend
- `spirv-headers_1.3.204.1` / `spirv-tools_1.3.204.1` - Provided by OE-core and extended as needed

The bbappend for vulkan-tools adds:
- CUBE build support (`-DBUILD_CUBE=ON`)
- Custom patches for Wayland support

## Versioning and Platform Usage

Platform-specific version selection is done via:

```conf
PREFERRED_VERSION_vulkan-headers = "1.3.260"
PREFERRED_VERSION_vulkan-loader  = "1.3.260"
PREFERRED_VERSION_vulkan-tools   = "1.3.260"
PREFERRED_VERSION_vulkan-validationlayers = "1.3.260"
```

These can be overridden per-platform in machine configuration files.

## Recipe Structure

- **Version 1.3.204**: Uses OE-core (Kirkstone) recipes with bbappends for customizations
- **Versions 1.3.247 and 1.3.260**: Complete recipes in this layer (not in OE-core)
- **vulkan-validationlayers**: All versions in this layer (not in OE-core)
- **SPIR-V dependencies**: For 1.3.204, `spirv-headers` and `spirv-tools` come from OE-core (Kirkstone); for newer SDKs, versions 1.3.247 and 1.3.260 are provided in this layer and follow the same versioning as the Vulkan components to keep the toolchain aligned with headers, loader, and validation layers

## Notes
- The upstream SPIR-V repositories do not ship explicit 1.3.247 / 1.3.260 tags; the recipes therefore use the closest published SDK tags (1.3.246.1 and 1.3.261.1) that ship with those Vulkan SDK drops.
