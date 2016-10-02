# XVM Native
project(xvm-native)
cmake_minimum_required (VERSION 3.0)

#cmake includes
include(GenerateExportHeader)

#cmake settings
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/binaries/)

#static runtime linking on MSVC
if(MSVC)
  add_definitions("-D_WINSOCK_DEPRECATED_NO_WARNINGS")

  foreach(flag_var CMAKE_C_FLAGS   CMAKE_C_FLAGS_DEBUG   CMAKE_C_FLAGS_RELEASE   CMAKE_C_FLAGS_MINSIZEREL   CMAKE_C_FLAGS_RELWITHDEBINFO
                   CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if(${flag_var} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif()
  endforeach()
endif()

#static runtime linking on GCC
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  list(APPEND CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-static-libgcc")
  list(APPEND CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "-static-libgcc -static-libstdc++")
endif()

#common includes
include_directories("${CMAKE_BINARY_DIR}")

##########################
# XVM.Native-Ping Module #
##########################
add_library(XVMNativePing SHARED "src/common/pythonWrapperHelper.c"
                                 "src/ping/ping.c"
                                 "src/ping/dllmain.c" 
                                 "src/ping/pythonModule.c"
                                 "src/ping/pythonWrapper.c" )  

generate_export_header(XVMNativePing)
target_include_directories(XVMNativePing PRIVATE "include/python-2.7.7" "src/common/" "src/ping/" )
target_link_libraries(XVMNativePing  "iphlpapi" "ws2_32" )

if(MSVC)
    set_target_properties(XVMNativePing PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

install(TARGETS  XVMNativePing
        RUNTIME DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime)


##########################
# XVM.Native-XPFIX Module #
##########################
add_library(XVMNativeXPFix SHARED "src/common/pythonWrapperHelper.c"
                                  "src/xpfix/findmodule.c"
                                  "src/xpfix/dllmain.c" 
                                  "src/xpfix/pythonModule.c"
                                  "src/xpfix/pythonWrapper.c" )  

generate_export_header(XVMNativeXPFix)
target_include_directories(XVMNativeXPFix PRIVATE "include/python-2.7.7" "src/common/" "src/xpfix/" )

if(MSVC)
    set_target_properties(XVMNativeXPFix PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

install(TARGETS  XVMNativeXPFix
        RUNTIME DESTINATION "./xfw/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./xfw/native/" COMPONENT Runtime)



########################
# XVM.Native-Ping Test #
########################
add_executable(XVMNativePing-test "src/ping/ping.c"
                                  "src/ping/pingTest.c" )
                  
target_include_directories(XVMNativePing-test PRIVATE "src/ping/")
target_link_libraries(XVMNativePing-test  "iphlpapi" "ws2_32")

if(MSVC)
    set_target_properties(XVMNativePing-test PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

install(TARGETS XVMNativePing-test DESTINATION ./tests/xvm_ping/)