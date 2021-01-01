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

project(xfw_filewatcher)
cmake_minimum_required (VERSION 3.0)

find_package(libpython REQUIRED)

add_library(xfw_filewatcher SHARED
        "src/fileWatcher.cpp"
        "src/pythonModule.cpp"
        "src/threadHelper.cpp"
        "../../library.rc"
)

set(VER_PRODUCTNAME_STR "XFW Filewatcher")
set(VER_FILEDESCRIPTION_STR "XFW Filewatcher module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_filewatcher.pyd")
set(VER_INTERNALNAME_STR "xfw_filewatcher")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_filewatcher PRIVATE "${CMAKE_BUILD_DIR}")

target_compile_options(xfw_filewatcher PRIVATE "/d2FH4-")

target_link_libraries(xfw_filewatcher PRIVATE libpython::python27)
set_target_properties(xfw_filewatcher PROPERTIES SUFFIX ".pyd")

install(TARGETS xfw_filewatcher
        RUNTIME DESTINATION ".")
