@echo off

rmdir /S /Q build
mkdir build
cd build

cmake .. -G "Visual Studio 15 2017" -T "v140_xp"

cmake --build . --config RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo

cd ..