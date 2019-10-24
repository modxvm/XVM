project(xfw_wwise)
cmake_minimum_required (VERSION 3.0)

find_package(audiokinetic REQUIRED)
find_package(libpython REQUIRED)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

#directories
add_library(xfw_wwise SHARED
  "src/path.cpp"
  "src/pythonModule.cpp"
  "../../library.rc"
)

set(VER_PRODUCTNAME_STR "XFW WWISE")
set(VER_FILEDESCRIPTION_STR "XFW WWISE module for World of Tanks")
set(VER_ORIGINALFILENAME_STR "xfw_wwise.pyd")
set(VER_INTERNALNAME_STR "xfw_wwise")
configure_file("../../library.h.in" "library.h" @ONLY)

target_include_directories(xfw_wwise PRIVATE "${CMAKE_BUILD_DIR}")

target_link_libraries(xfw_wwise audiokinetic::audiokinetic)
target_link_libraries(xfw_wwise libpython::python27)
target_link_libraries(xfw_wwise "shlwapi")

if(MSVC)
  target_compile_definitions(xfw_wwise PRIVATE "-D_CRT_SECURE_NO_WARNINGS")
  target_compile_options(xfw_wwise PRIVATE "/d2FH4-")
  set_target_properties(xfw_wwise PROPERTIES COMPILE_FLAGS "/wd4005")
  set_target_properties(xfw_wwise PROPERTIES LINK_FLAGS "/INCREMENTAL:NO")
endif()

set_target_properties(xfw_wwise PROPERTIES SUFFIX ".pyd")

install(TARGETS  xfw_wwise
        RUNTIME DESTINATION ".")
