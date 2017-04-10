project(findwot)
cmake_minimum_required(VERSION 3.6)

include("ucm.cmake")
ucm_set_runtime(STATIC)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/bin/)

set(SOURCES_LIB "src/findwot.cpp")
set(SOURCES_TEST "src/findwot_test.cpp")
include_directories("src/rapidxml")

add_library(findwot SHARED "${SOURCES_LIB}")
add_executable(findwot_test "${SOURCES_LIB}" "${SOURCES_TEST}")

install(TARGETS findwot findwot_test DESTINATION .)