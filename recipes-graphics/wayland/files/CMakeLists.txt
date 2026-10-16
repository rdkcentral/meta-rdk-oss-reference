cmake_minimum_required(VERSION 3.15)

project(wayland-egl VERSION 1.18.0 DESCRIPTION "Frontend wayland-egl library")

include(GNUInstallDirs)

add_library(${PROJECT_NAME} SHARED wayland-egl.c)

set_target_properties(${PROJECT_NAME} PROPERTIES
    VERSION 1.0.0 SOVERSION 1)

install(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

set(prefix "/usr")
set(exec_prefix "\${prefix}")
set(libdir "\${exec_prefix}/lib")
set(includedir "\${prefix}/include")

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/wayland-egl.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/wayland-egl.pc
    @ONLY)

# Install the pkg-config file
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/wayland-egl.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
