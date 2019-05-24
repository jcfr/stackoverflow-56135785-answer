cmake_minimum_required(VERSION 3.7)
project(FOOBAR VERSION 1.2.3)
set(VERSION 1.2.3)

set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib:$ORIGIN/")
set(CMAKE_INSTALL_PREFIX "/opt/foobar" CACHE PATH "Install path prefix" FORCE)

add_library(foobar SHARED
  foobar.cpp
)

set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
set(CPACK_PACKAGE_NAME "foobar")

set(CPACK_PACKAGE_VERSION ${VERSION})
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")

include(CPack)

# Indicate the content of the distribution pakcages
install(FILES
  ${CMAKE_SOURCE_DIR}/foobar.h
  DESTINATION include
)
install(TARGETS
  foobar
  EXPORT foobarLibTargets
  LIBRARY DESTINATION lib)

include(CMakePackageConfigHelpers)
set(ConfigFileInstallDir lib/cmake/foobar)
set(INCLUDE_INSTALL_DIR include)
set(LIBRARY_INSTALL_DIR lib)
message(STATUS "CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}")
configure_package_config_file(foobarConfig.cmake.in
     "${CMAKE_BINARY_DIR}/foobarConfig.cmake"
    INSTALL_DESTINATION "${ConfigFileInstallDir}"
    PATH_VARS INCLUDE_INSTALL_DIR LIBRARY_INSTALL_DIR)
write_basic_package_version_file(
   "${CMAKE_BINARY_DIR}/foobarConfigVersion.cmake"
   VERSION "${VERSION}"
   COMPATIBILITY ExactVersion)
export(EXPORT foobarLibTargets
       FILE "${CMAKE_CURRENT_BINARY_DIR}/foobarLibTargets.cmake")
install(EXPORT foobarLibTargets
        FILE foobarTargets.cmake
        DESTINATION lib/cmake)
install(FILES
   "${CMAKE_CURRENT_BINARY_DIR}/foobarConfig.cmake"
   "${CMAKE_CURRENT_BINARY_DIR}/foobarConfigVersion.cmake"
   "${CMAKE_CURRENT_BINARY_DIR}/foobarLibTargets.cmake"
    DESTINATION "${ConfigFileInstallDir}")
