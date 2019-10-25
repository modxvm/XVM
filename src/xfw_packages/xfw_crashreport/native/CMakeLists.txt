cmake_minimum_required (VERSION 3.10)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

project(xfw_crashreport LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(libpython REQUIRED)

add_definitions(-D_UNICODE)

add_library(xfw_crashreport SHARED
        "src/common.cpp"
        "src/crashreporter.cpp"
        "src/dllMain.cpp"
        "src/fix_suef.cpp"
        "src/pythonModule.cpp"
        "../../library.rc"
)


set(VER_PRODUCTNAME_STR "XFW Crashreport")
set(VER_FILEDESCRIPTION_STR "XFW Crashreport module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_crashreport.pyd")
set(VER_INTERNALNAME_STR "xfw_crashreport")
configure_file("../../library.h.in" "library.h" @ONLY)
target_include_directories(xfw_crashreport PRIVATE "${CMAKE_BUILD_DIR}")

target_compile_definitions(xfw_crashreport PRIVATE "-D_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING")
target_compile_definitions(xfw_crashreport PRIVATE "-D_CRT_SECURE_NO_WARNINGS")

target_compile_options(xfw_crashreport PRIVATE "/d2FH4-")

set_target_properties(xfw_crashreport PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")

#dep: python
target_link_libraries(xfw_crashreport libpython::python27)
set_target_properties(xfw_crashreport PROPERTIES SUFFIX ".pyd")

#dep: crashrpt
target_include_directories(xfw_crashreport PRIVATE "crashrpt/include")
target_link_libraries(xfw_crashreport "${CMAKE_SOURCE_DIR}/crashrpt/lib/CrashRpt1500.lib")
set_target_properties(xfw_crashreport PROPERTIES LINK_FLAGS "/DELAYLOAD:CrashRpt1500.dll")

#dep: windows
target_link_libraries(xfw_crashreport "Shlwapi")
target_link_libraries(xfw_crashreport "Version")

#install
install(TARGETS xfw_crashreport
        RUNTIME DESTINATION ".")

install(DIRECTORY "crashrpt/bin/" DESTINATION ".")

install(DIRECTORY "crashrpt/lang_files/" DESTINATION "./lang_files/")