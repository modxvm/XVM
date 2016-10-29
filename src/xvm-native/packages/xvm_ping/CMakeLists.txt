project(xvm-ping)
cmake_minimum_required (VERSION 3.0)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/../../release/)

#directories
include_directories("../../libpython/release/libpython/include/python2.7")
link_directories("../../libpython/release/libpython/lib")

add_library(XVMNativePing SHARED "src/ping.c"
                                 "src/dllmain.c" 
                                 "src/pythonModule.c")  

target_link_libraries(XVMNativePing  "iphlpapi" "ws2_32" "python27")

if(MSVC)
    set_target_properties(XVMNativePing PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

set_target_properties(XVMNativePing PROPERTIES SUFFIX ".pyd")

install(TARGETS  XVMNativePing
        RUNTIME DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime)