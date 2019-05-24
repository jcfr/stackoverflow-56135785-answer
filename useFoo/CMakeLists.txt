cmake_minimum_required(VERSION 3.7)
project(useFoo VERSION 1.2.3)
set(VERSION 1.2.3)

find_package(foobar)
file(GENERATE OUTPUT foobar-gen CONTENT "<TARGET_FILE:foobar>=$<TARGET_FILE:foobar>\n")

message(STATUS "FOOBAR_LIBRARY_DIR=${FOOBAR_LIBRARY_DIR}")
message(STATUS "FOOBAR_INCLUDE_DIR=${FOOBAR_INCLUDE_DIR}")
