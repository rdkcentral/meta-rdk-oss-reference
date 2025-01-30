FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
PACKAGECONFIG_append_class-target = " egl glesv2"
PACKAGECONFIG_remove = "directfb"

#From meta-rdk-ext
SRC_URI_append = " file://cairo-egl-device-create-for-egl-surface.patch \
                   file://0008-add-noaa-compositor.patch \ 
                   file://cairo_scaled_font_destroy_Assertion.patch"

#From meta-rdk-comcast-video/recipes-graphics/cairo/cairo_1.14.6.bbappend
SRC_URI_append = " file://CVE-2016-9082_cairo_1.14.6_fix.patch \
                   file://CVE-2020-35492_cairo_1.14.6_fix.patch"

