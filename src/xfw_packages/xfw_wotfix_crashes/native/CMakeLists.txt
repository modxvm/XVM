cmake_minimum_required (VERSION 3.0)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

project(xfw_crashfix LANGUAGES C)

find_package(libpython REQUIRED)

add_library(xfw_crashfix SHARED
        "src/pythonModule.c"
        "src/common.c"

        "src/bugfix_1.c"
        "src/bugfix_1.h"

        "src/bugfix_2.c"
        "src/bugfix_2.h"

        "src/bugfix_3.c"
        "src/bugfix_3.h"

        "src/bugfix_4.c"
        "src/bugfix_4.h"

        "../../library.rc"
)

set(VER_PRODUCTNAME_STR "XFW Crashfix")
set(VER_FILEDESCRIPTION_STR "XFW Crashfix module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_crashfix.pyd")
set(VER_INTERNALNAME_STR "xfw_crashfix")
configure_file("../../library.h.in" "library.h" @ONLY)

target_compile_definitions(xfw_crashfix PRIVATE "_CRT_SECURE_NO_WARNINGS")

target_compile_options(xfw_crashfix PRIVATE "/d2FH4-")

set_target_properties(xfw_crashfix PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")

target_link_libraries(xfw_crashfix libpython::python27)
set_target_properties(xfw_crashfix PROPERTIES SUFFIX ".pyd")
target_include_directories(xfw_crashfix PRIVATE "${CMAKE_BUILD_DIR}")

install(TARGETS xfw_crashfix
        RUNTIME DESTINATION ".")
