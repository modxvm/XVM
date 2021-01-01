# This file is part of the XVM project.
#
# Copyright (c) 2018-2021 XVM Team.
#
# This file is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, version 3.
#
# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cmake_minimum_required (VERSION 3.0)
project(xfw_ping LANGUAGES C)

find_package(libpython REQUIRED)

add_library(xfw_ping SHARED
        "src/ping.c"
        "src/pythonModule.c"
        "../../library.rc"
)

set(VER_PRODUCTNAME_STR "XFW Ping")
set(VER_FILEDESCRIPTION_STR "XFW Ping module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_ping.pyd")
set(VER_INTERNALNAME_STR "xfw_ping")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_ping PRIVATE "${CMAKE_BUILD_DIR}")

target_compile_options(xfw_ping PRIVATE "/d2FH4-")

target_link_libraries(xfw_ping "iphlpapi")
target_link_libraries(xfw_ping "ws2_32")
target_link_libraries(xfw_ping libpython::python27)

set_target_properties(xfw_ping PROPERTIES SUFFIX ".pyd")

install(TARGETS xfw_ping
        RUNTIME DESTINATION ".")
