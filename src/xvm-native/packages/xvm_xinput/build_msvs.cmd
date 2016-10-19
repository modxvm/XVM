@echo off

rmdir /S /Q build
mkdir build
cd build

cmake ..
cmake --build . --config RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo
