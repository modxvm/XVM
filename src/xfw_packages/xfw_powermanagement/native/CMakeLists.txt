# This file is part of the XVM project.
#
# Copyright (c) 2018-2019 XVM Team.
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
project(xfw_powermanagement LANGUAGES C)

find_package(libpython REQUIRED)

add_library(xfw_powermanagement SHARED 
        "src/pythonModule.c"
        "../../library.rc"	
)  
        
set(VER_PRODUCTNAME_STR "XFW Power Management")
set(VER_FILEDESCRIPTION_STR "XFW Power Management for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_powermanagement.pyd")
set(VER_INTERNALNAME_STR "xfw_powermanagement")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_powermanagement PRIVATE "${CMAKE_BUILD_DIR}")
        
target_link_libraries(xfw_powermanagement libpython::python27)

set_target_properties(xfw_powermanagement PROPERTIES SUFFIX ".pyd")

install(TARGETS xfw_powermanagement
        RUNTIME DESTINATION ".")
