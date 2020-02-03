cmake_minimum_required (VERSION 3.10)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

project(xfw_crashreport LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(libpython REQUIRED)

add_definitions(-D_UNICODE)

add_library(xfw_crashreport SHARED
        "src/common.cpp"
        "src/common.h"

        "src/crashreporter.cpp"
        "src/crashreporter.h"
        
        "src/dllMain.cpp"
        "src/dllMain.h"

        "src/fix_suef.cpp"
        "src/fix_suef.h"
        
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
target_include_directories(xfw_crashreport PRIVATE "3rdparty/sentry-native/include")
if(CMAKE_CL_64)
    target_link_libraries(xfw_crashreport "${CMAKE_SOURCE_DIR}/3rdparty/sentry-native/lib64/sentry_crashpad.lib")
else()
    target_link_libraries(xfw_crashreport "${CMAKE_SOURCE_DIR}/3rdparty/sentry-native/lib32/sentry_crashpad.lib")
endif()
set_target_properties(xfw_crashreport PROPERTIES LINK_FLAGS "/DELAYLOAD:sentry_crashpad.dll")

#dep: windows
target_link_libraries(xfw_crashreport "Shlwapi")
target_link_libraries(xfw_crashreport "Version")

#install
install(TARGETS xfw_crashreport
        RUNTIME DESTINATION ".")

if(CMAKE_CL_64)
    install(DIRECTORY "3rdparty/sentry-native/bin64/" DESTINATION ".")
else()
    install(DIRECTORY "3rdparty/sentry-native/bin32/" DESTINATION ".")
endif()
