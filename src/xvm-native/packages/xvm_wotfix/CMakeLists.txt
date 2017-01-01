project(xvm_wotfix)
cmake_minimum_required (VERSION 3.0)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/../../release/xfw/native)
endif()

set(CMAKE_INCLUDE_CURRENT_DIR ON)

#directories
include_directories("../../libpython/release/libpython/include/python2.7")
link_directories("../../libpython/release/libpython/lib")

add_library(XVMNativeWOTFix SHARED "src/dllMain.c" 
                                   "src/pythonModule.c"

                                   "src/impl/find_init_module.c"
                                   "src/impl/load_source_module.c"
                                   "src/impl/_PyImport_GetDynLoadFunc.c")  

target_compile_definitions(XVMNativeWOTFix PRIVATE "_CRT_SECURE_NO_WARNINGS")
set_target_properties(XVMNativeWOTFix PROPERTIES SUFFIX ".pyd")

install(TARGETS XVMNativeWOTFix
        RUNTIME DESTINATION "." COMPONENT Runtime
        LIBRARY DESTINATION "." COMPONENT Runtime)