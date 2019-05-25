cmake_minimum_required(VERSION 3.13)

project(FooBarLib VERSION 1.2.3)

if(UNIX AND NOT APPLE)
  set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib:$ORIGIN/")
endif()

#------------------------------------------------------------------------------
# Set a default build type if none was specified
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
  mark_as_advanced(CMAKE_BUILD_TYPE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

#------------------------------------------------------------------------------
# This variable controls the prefix used to generate the following files:
#  <export_config_name>ConfigVersion.cmake
#  <export_config_name>Config.cmake
#  <export_config_name>Targets.cmake
# and it also used to initialize FOOBARLIB_INSTALL_CONFIG_DIR value.
set(export_config_name ${PROJECT_NAME})

#------------------------------------------------------------------------------
if(NOT DEFINED FOOBARLIB_INSTALL_INCLUDE_DIR)
  set(FOOBARLIB_INSTALL_INCLUDE_DIR include)
endif()

if(NOT DEFINED FOOBARLIB_INSTALL_BIN_DIR)
  set(FOOBARLIB_INSTALL_BIN_DIR bin)
endif()

if(NOT DEFINED FOOBARLIB_INSTALL_LIBRARY_DIR)
  set(FOOBARLIB_INSTALL_LIBRARY_DIR lib)
endif()

if(NOT DEFINED FOOBARLIB_INSTALL_CONFIG_DIR)
  set(FOOBARLIB_INSTALL_CONFIG_DIR ${FOOBARLIB_INSTALL_LIBRARY_DIR}/cmake/${export_config_name})
endif()

#------------------------------------------------------------------------------
set(headers
  foobar.h
  )

# Install rule for headers
install(
  FILES ${headers}
  DESTINATION ${FOOBARLIB_INSTALL_INCLUDE_DIR}
  COMPONENT Development
  )

#------------------------------------------------------------------------------
add_library(foobar SHARED
  foobar.cpp
  )

target_include_directories(foobar
  PUBLIC
    $<BUILD_INTERFACE:${FooBarLib_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${FOOBARLIB_INSTALL_INCLUDE_DIR}>
  )

install(
  TARGETS foobar
  EXPORT ${export_config_name}Targets
  ARCHIVE DESTINATION ${FOOBARLIB_INSTALL_LIBRARY_DIR} COMPONENT Development
  LIBRARY DESTINATION ${FOOBARLIB_INSTALL_LIBRARY_DIR} COMPONENT RuntimeLibraries
  RUNTIME DESTINATION ${FOOBARLIB_INSTALL_BIN_DIR} COMPONENT RuntimeLibraries
  )

#------------------------------------------------------------------------------
# Configure <export_config_name>ConfigVersion.cmake common to build and install tree
include(CMakePackageConfigHelpers)
set(config_version_file ${PROJECT_BINARY_DIR}/${export_config_name}ConfigVersion.cmake)
write_basic_package_version_file(
  ${config_version_file}
  VERSION "${FooBarLib_VERSION}"
  COMPATIBILITY ExactVersion
  )

#------------------------------------------------------------------------------
# Export '<export_config_name>Targets.cmake' for a build tree
export(
  EXPORT ${PROJECT_NAME}Targets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/${export_config_name}Targets.cmake"
  )

# Configure '<export_config_name>Config.cmake' for a build tree
set(build_config ${CMAKE_BINARY_DIR}/${export_config_name}Config.cmake)
configure_package_config_file(
  ${export_config_name}Config.cmake.in 
  ${build_config}
  INSTALL_DESTINATION "${PROJECT_BINARY_DIR}"
  )

#------------------------------------------------------------------------------
# Export '<export_config_name>Targets.cmake' for an install tree
install(
  EXPORT ${export_config_name}Targets
  FILE ${export_config_name}Targets.cmake
  DESTINATION ${FOOBARLIB_INSTALL_CONFIG_DIR}
  )

set(install_config ${PROJECT_BINARY_DIR}/CMakeFiles/${export_config_name}Config.cmake)
configure_package_config_file(
  ${export_config_name}Config.cmake.in 
  ${install_config}
  INSTALL_DESTINATION ${FOOBARLIB_INSTALL_CONFIG_DIR}
  )

# Install config files
install(
  FILES ${config_version_file} ${install_config}
  DESTINATION "${FOOBARLIB_INSTALL_CONFIG_DIR}"
  )

#------------------------------------------------------------------------------
# Generate package

set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")

# Setting CPACK_SOURCE_* and CPACK_GENERATOR allow to have "make package" generates
# the expected archive.

# Disable source generator enabled by default
set(CPACK_SOURCE_TBZ2 OFF CACHE BOOL "Enable to build TBZ2 source packages" FORCE)
set(CPACK_SOURCE_TGZ  OFF CACHE BOOL "Enable to build TGZ source packages" FORCE)
set(CPACK_SOURCE_TZ OFF CACHE BOOL "Enable to build TZ source packages" FORCE)

# Select generator
if(UNIX)
  set(CPACK_GENERATOR "TGZ")
  if(APPLE)
    # ...
  endif()
endif()

include(CPack)
