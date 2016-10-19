project(xvm-xpfix)
cmake_minimum_required (VERSION 3.0)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/../../release/)

#directories
include_directories("../../libpython/release/libpython/include/python2.7"
                    "src"
                    "src/impl")

link_directories("../../libpython/release/libpython/lib")

add_library(XVMNativeXPFix SHARED "src/dllmain.c" 
                                  "src/injector.c"
                                  "src/pythonModule.c"
                                  "src/impl/find_init_module.c"
                                  "src/impl/load_source_module.c")  

target_compile_definitions(XVMNativeXPFix PRIVATE "_CRT_SECURE_NO_WARNINGS")

install(TARGETS  XVMNativeXPFix
        RUNTIME DESTINATION "./xfw/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./xfw/native/" COMPONENT Runtime)