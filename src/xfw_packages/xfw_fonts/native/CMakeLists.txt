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
project(xfw_fonts LANGUAGES CXX)

find_package(libpython REQUIRED)
find_package(minhook REQUIRED)

include_directories("src")

add_library(xfw_fonts SHARED
        "src/pythonModule.cpp"
        "src/ttfInfo.cpp"
        "src/winapi_CreateFont.cpp"
        "src/winapi_EnumFontsFamiliesEx.cpp"
        "../../library.rc"
)

set(VER_PRODUCTNAME_STR "XFW Fonts")
set(VER_FILEDESCRIPTION_STR "XFW Fonts module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_fonts.pyd")
set(VER_INTERNALNAME_STR "xfw_fonts")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_fonts PRIVATE "${CMAKE_BUILD_DIR}")

target_compile_definitions(xfw_fonts PRIVATE "_CRT_SECURE_NO_WARNINGS")

target_compile_options(xfw_fonts PRIVATE "/d2FH4-")

target_link_libraries(xfw_fonts libpython::python27)
target_link_libraries(xfw_fonts minhook::minhook)
set_target_properties(xfw_fonts PROPERTIES SUFFIX ".pyd")
set_target_properties(xfw_fonts PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")

install(TARGETS xfw_fonts
        RUNTIME DESTINATION ".")
