cmake_minimum_required(VERSION 3.13)

project(useFoo VERSION 1.2.3)

find_package(FooBarLib REQUIRED)

file(GENERATE OUTPUT foobar-gen CONTENT "<TARGET_FILE:foobar>=$<TARGET_FILE:foobar>\n")

get_target_property(foobar_INCLUDE_DIR foobar INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "foobar_INCLUDE_DIR=${foobar_INCLUDE_DIR}")

get_target_property(imported_location foobar IMPORTED_LOCATION_RELEASE)
get_filename_component(foobar_LIBRARY_DIR ${imported_location} DIRECTORY)
message(STATUS "foobar_LIBRARY_DIR=${foobar_LIBRARY_DIR}")
