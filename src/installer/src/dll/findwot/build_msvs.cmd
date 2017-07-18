@echo off

rmdir /S /Q build
mkdir build
cd build

cmake .. -T "v141_xp"
cmake --build . --target INSTALL --config Release
