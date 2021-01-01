# This file is part of the Findwot project.
#
# Copyright (c) 2016-2021 Findwot contributors.
#
# Findwot is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# Findwot is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

project(findwot)
cmake_minimum_required(VERSION 3.6)

include("ucm.cmake")
ucm_set_runtime(STATIC)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/bin/)

set(SOURCES_LIB
    "src/api.cpp"
    "src/dll.cpp"
    "src/registry.cpp"
    "src/filesystem.cpp"
    "src/wotdetector.cpp"
    "src/vector.cpp"
    "src/wgc.cpp"
    "src/wine.cpp"
    "src/wotclient.cpp"
    "src/wotlauncher.cpp"
    "src/string.cpp"
)

set(HEADERS_LIB
    "src/api.h"
    "src/registry.h"
    "src/filesystem.h"
    "src/wotdetector.h"
    "src/vector.h"
    "src/wgc.h"
    "src/wine.h"
    "src/wotclient.h"
    "src/wotlauncher.h"
    "src/string.h"
)

set(SOURCES_TEST "src/findwot_test.cpp")
include_directories("src/rapidxml")

add_library(findwot SHARED ${SOURCES_LIB} ${HEADERS_LIB})
target_link_libraries(findwot "Version" "Kernel32")
target_compile_definitions(findwot PRIVATE "-DBUILD_WOTDETECTOR")
target_compile_definitions(findwot PRIVATE "-D_CRT_SECURE_NO_WARNINGS")

add_executable(findwot_test "${SOURCES_TEST}")
target_link_libraries(findwot_test findwot)

install(TARGETS findwot findwot_test DESTINATION .)
