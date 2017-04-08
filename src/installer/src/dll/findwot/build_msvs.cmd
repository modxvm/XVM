@echo off

rmdir /S /Q build
mkdir build
cd build

cmake .. -T "v140_xp"
cmake --build . --config RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo
