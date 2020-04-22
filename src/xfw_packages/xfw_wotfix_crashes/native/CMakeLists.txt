cmake_minimum_required (VERSION 3.0)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

project(xfw_crashfix LANGUAGES C ASM_MASM)

find_package(libpython REQUIRED)

add_library(xfw_crashfix SHARED)

target_sources(xfw_crashfix PRIVATE
    "../../library.rc"
    "pythonModule.c"
)

if("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "x64")

    target_sources(xfw_crashfix PRIVATE
        "64_common.c"
        "64_patch.c"
        "64_patch_1.c"
        "64_patch_1.asm"
    )

else()

    target_sources(xfw_crashfix PRIVATE
        "32_common.c"
        "32_patch.c"
        "32_patch_1.c"
        "32_patch_2.c"
        "32_patch_3.c"
        "32_patch_4.c"
    )

endif()

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
