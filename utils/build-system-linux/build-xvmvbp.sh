#!/bin/bash

#XVM Vehicle Bank Parser builder for Linux
#Part of XVM build system
#Do not change anything in this file if you are not sure

#1. Detect revision
pushd ../../ > /dev/null
revision=$(svnversion | head -c 4)
popd > /dev/null

#2. Build XVM-stat
pushd sh > /dev/null
./xvmvbp-build.sh
popd > /dev/null

#3. Make dirs
mkdir -p ../../bin
rm -rf ../../bin/*

#4. Build zips
rm -rf ../../src/vehicle-bank-parser/builds/Release/obj-VehicleBankParser/
cp -f ../../src/vehicle-bank-parser/wottools.exe ../../src/vehicle-bank-parser/builds/Release/
echo "$revision" >> ../../src/vehicle-bank-parser/builds/Release/"$revision"
pushd ../../src/vehicle-bank-parser/builds/Release/ > /dev/null && zip -9 -r -q "$revision"_xvmvbp.zip ./ && popd > /dev/null

#5. Move&Clean
mv -f ../../src/vehicle-bank-parser/builds/Release/"$revision"_xvmvbp.zip ../../bin/

rm -rf ../../src/vehicle-bank-parser/builds/*
