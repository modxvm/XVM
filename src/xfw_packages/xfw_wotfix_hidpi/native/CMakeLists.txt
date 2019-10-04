cmake_minimum_required (VERSION 3.0)

project(xfw_hidpi LANGUAGES C)

find_package(libpython REQUIRED)

add_library(xfw_hidpi SHARED
	"src/pythonModule.c"
	"../../library.rc"	
)  

set(VER_PRODUCTNAME_STR "XFW HiDPI")
set(VER_FILEDESCRIPTION_STR "XFW HiDPI module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_hidpi.pyd")
set(VER_INTERNALNAME_STR "xfw_hidpi")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_hidpi PRIVATE "${CMAKE_BUILD_DIR}")

target_compile_definitions(xfw_hidpi PRIVATE "_CRT_SECURE_NO_WARNINGS")

set_target_properties(xfw_hidpi PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")

target_link_libraries(xfw_hidpi libpython::python27)
target_link_libraries(xfw_hidpi "shlwapi")

set_target_properties(xfw_hidpi PROPERTIES SUFFIX ".pyd")

install(TARGETS xfw_hidpi
        RUNTIME DESTINATION ".")