# XVM Native ping module

project(xvm-ping)
cmake_minimum_required (VERSION 3.0)

#cmake includes
include(GenerateExportHeader)

#cmake settings
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/binaries/)

#Static runtime linking on MSVC
if(MSVC)
  add_definitions("-D_WINSOCK_DEPRECATED_NO_WARNINGS")

  foreach(flag_var CMAKE_C_FLAGS   CMAKE_C_FLAGS_DEBUG   CMAKE_C_FLAGS_RELEASE   CMAKE_C_FLAGS_MINSIZEREL   CMAKE_C_FLAGS_RELWITHDEBINFO
                   CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if(${flag_var} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif()
  endforeach()
endif()

#Static runtime linking on GCC
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  list(APPEND CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-static-libgcc")
  list(APPEND CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "-static-libgcc -static-libstdc++")
endif()

#C includes
include_directories("include/python-2.7.7")
include_directories("${CMAKE_BINARY_DIR}")

##########################
# XVM.Native-Ping Module #
##########################

add_library(XVMNativePing SHARED "src/ping/common/ping.c"
                                 "src/ping/dll/dllmain.c" 
                                 "src/ping/dll/pythonmodule.c"
                                 "src/ping/dll/pythonwrapper.c" )  

generate_export_header(XVMNativePing)

#suppress warning on MSVC
if(MSVC)
    set_target_properties(XVMNativePing PROPERTIES COMPILE_FLAGS "/wd4005")
endif()

target_include_directories(XVMNativePing PRIVATE "src/ping/common"
                                                 "src/ping/dll" )

target_link_libraries(XVMNativePing  "iphlpapi" 
                                     "ws2_32" )

install(TARGETS  XVMNativePing
        RUNTIME DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime
        LIBRARY DESTINATION "./packages/xvm_ping/native/" COMPONENT Runtime)


########################
# XVM.Native-Ping Test #
########################
add_executable(XVMNativePing-test "src/ping/common/ping.c"
                                  "src/ping/test/main.c" )                   
set_target_properties(XVMNativePing-test PROPERTIES COMPILE_FLAGS "/wd4005")
target_include_directories(XVMNativePing-test PRIVATE "src/ping/common")
target_link_libraries(XVMNativePing-test  "iphlpapi" "ws2_32")
install(TARGETS XVMNativePing-test DESTINATION ./tests/xvm_ping/)