project(xvm_sounds)
cmake_minimum_required (VERSION 3.0)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/../../release/)

#directories
include_directories("../../libpython/release/libpython/include/python2.7")
link_directories("../../libpython/release/libpython/lib")

add_library(XVMNativeSounds SHARED "src/audiokinetic.c"
                                   "src/dllmain.c" 
                                   "src/pythonModule.c")  

target_link_libraries(XVMNativeSounds "python27")

if(MSVC)
    set_target_properties(XVMNativeSounds PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

set_target_properties(XVMNativeSounds PROPERTIES SUFFIX ".pyd")

install(TARGETS  XVMNativeSounds
        RUNTIME DESTINATION "./packages/xvm_sounds/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./packages/xvm_sounds/native/" COMPONENT Runtime)