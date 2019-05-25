cmake_minimum_required(VERSION 3.13)

project(useFoo VERSION 1.2.3)

find_package(foobar REQUIRED)

file(GENERATE OUTPUT foobar-gen CONTENT "<TARGET_FILE:foobar>=$<TARGET_FILE:foobar>\n")

get_target_property(FOOBAR_INCLUDE_DIR foobar INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "FOOBAR_INCLUDE_DIR=${FOOBAR_INCLUDE_DIR}")

get_target_property(imported_location foobar IMPORTED_LOCATION_RELEASE)
get_filename_component(FOOBAR_LIBRARY_DIR ${imported_location} DIRECTORY)
message(STATUS "FOOBAR_LIBRARY_DIR=${FOOBAR_LIBRARY_DIR}")
