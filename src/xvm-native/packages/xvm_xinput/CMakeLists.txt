project(xvm-xinput)
cmake_minimum_required (VERSION 3.0)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/../../release/)

#directories
include_directories("../../libpython/release/libpython/include/python2.7")
link_directories("../../libpython/release/libpython/lib")
link_directories("lib")


add_library(XVMNativeXInput SHARED "src/dllmain.c" 
                                   "src/pythonModule.c")  

target_link_libraries(XVMNativeXInput "XInput" "python27")

if(MSVC)
    set_target_properties(XVMNativeXInput PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

install(TARGETS  XVMNativeXInput
        RUNTIME DESTINATION "./packages/xvm_xinput/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./packages/xvm_xinput/native/" COMPONENT Runtime)